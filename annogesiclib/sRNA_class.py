import os
import sys
import itertools
from annogesiclib.gff3 import Gff3Parser


def print_intersection(datas, keys, num_srna, gff_name, type_, out_stat):
    num = 0
    datas_merge = []
    if type_ == "total":
        out = open(gff_name, "w")
        out.write("##gff-version 3\n")
    for data in datas[keys[0]]:
        check_same = []
        for key in keys[1:]:
            if data in datas[key]:
                check_same.append("True")
        if len(check_same) == (len(keys) - 1):
            if len(keys) <= 5:
                if type_ == "total":
                    out.write(data.info + "\t" + "\n")
            if "best_avg_coverage" in data.attributes.keys():
                datas_merge.append({"data": data,
                            "wig": data.attributes["best_avg_coverage"]})
            num += 1
#    print(keys)
#    if len(keys) == 5:
    datas_sort = sorted(datas_merge, key=lambda k: float(k['wig']),
                        reverse=True)
    for data in datas_sort:
        if type_ == "total":
            out.write(data["data"].info + "\n")
    if num_srna == 0:
        out_stat.write("\t{0} = {1}({2})\n".format(" and ".join(keys),
                       str(num), str(0)))
    else:
        out_stat.write("\t{0} = {1}({2})\n".format(" and ".join(keys),
                       str(num), str(float(num)/float(num_srna))))
    if type_ == "total":
        out.close()

def initiate(key, key_list, class_name, class_num, index, out, content):
    if key in key_list:
        class_num += 1
        index[class_name] = class_num
        out.write(str(class_num) + content + "\n")
    return class_num

def import_class(class_num, datas_srna, datas, index, num_srna, strain,
                 type_, utr, energy, hit_nr_num):
    for num in range(1, class_num + 1):
        datas_srna["class_" + str(num)] = []
    for data in datas[strain]:
        detect = False
        if (data.source == type_) or (type_ == "total"):
            if type_ == "UTR_derived":
                if utr in data.attributes["UTR_type"]:
                    detect = True
            else:
                detect = True
            if detect:
                num_srna += 1
                if "2d_energy" in data.attributes.keys():
                    if float(data.attributes["2d_energy"]) < energy:
                        datas_srna["class_" + str(index["2d_energy"])].append(data)
                if "with_TSS" in data.attributes.keys():
                    if data.attributes["with_TSS"] != "NA":
                        datas_srna["class_" + str(index["with_TSS"])].append(data)
                    elif ((type_ == "UTR_derived") or (type_ == "total")) and (
                           data.source == "UTR_derived"):
                        if (data.attributes["start_cleavage"] != "NA") and (
                            ("3utr" in data.attributes["UTR_type"]) or (
                             "interCDS" in data.attributes["UTR_type"])):
                            datas_srna["class_" + str(index["with_TSS"])].append(data)
                if "nr_hit" in data.attributes.keys():
                    if ((data.attributes["nr_hit"] != "NA") and (
                        int(data.attributes["nr_hit"]) <= hit_nr_num)) or (
                        data.attributes["nr_hit"] == "NA"):
                        datas_srna["class_" + str(index["nr_no_hit"])].append(data)
                if "sORF" in data.attributes.keys():
                    if (data.attributes["sORF"] == "NA"):
                        datas_srna["class_" + str(index["sORF"])].append(data)
                if "sRNA_hit" in data.attributes.keys():
                    if data.attributes["sRNA_hit"] != "NA":
                        datas_srna["class_" + str(index["sRNA_hit"])].append(data)
                    else:
                        datas_srna["class_" + str(index["sRNA_no_hit"])].append(data)
                if "with_term" in data.attributes.keys():
                    if (data.attributes["with_term"] != "NA"):
                        datas_srna["class_" + str(index["with_term"])].append(data)
                    elif ("end_cleavage" in data.attributes.keys()):
                        if data.attributes["end_cleavage"] != "NA":
                            datas_srna["class_" + str(index["with_term"])].append(data)
    return num_srna

def import_data(class_num, datas, index, num_srna,
                strain, checks, energy, hit_nr_num):
    datas_srna = {}
    if checks["utr"]:
        datas_srna["5'UTR_derived"] = {}
        num_srna["5'UTR_derived"] = import_class(class_num,
                                    datas_srna["5'UTR_derived"], datas, index,
                                    num_srna["5'UTR_derived"], strain,
                                    "UTR_derived", "5utr", energy, hit_nr_num)
        datas_srna["3'UTR_derived"] = {}
        num_srna["3'UTR_derived"] = import_class(class_num,
                                    datas_srna["3'UTR_derived"], datas, index,
                                    num_srna["3'UTR_derived"], strain,
                                    "UTR_derived", "3utr", energy, hit_nr_num)
        datas_srna["interCDS"] = {}
        num_srna["interCDS"] = import_class(class_num, datas_srna["interCDS"],
                               datas, index, num_srna["interCDS"], strain,
                               "UTR_derived", "interCDS", energy, hit_nr_num)
    if checks["inter"]:
        datas_srna["intergenic"] = {}
        num_srna["intergenic"] = import_class(class_num,
                                 datas_srna["intergenic"],
                                 datas, index, num_srna["intergenic"], strain,
                                 "intergenic", None, energy, hit_nr_num)
    if checks["in_CDS"]:
        datas_srna["in_CDS"] = {}
        num_srna["in_CDS"] = import_class(class_num,
                                 datas_srna["in_CDS"],
                                 datas, index, num_srna["in_CDS"], strain,
                                 "in_CDS", None, energy, hit_nr_num)
    if (checks["utr"]) or (checks["in_CDS"]):
        datas_srna["total"] = {}
        num_srna["total"] = import_class(class_num, datas_srna["total"], datas,
                            index, num_srna["total"], strain, "total", None,
                            energy, hit_nr_num)
    return datas_srna

def sort_keys(keys):
    nums = []
    final_keys = []
    for key in keys:
        nums.append(int(key.split("_")[1]))
    nums = sorted(nums)
    for num in nums:
        final_keys.append("_".join(["class", str(num)]))
    return final_keys

def print_stat_title(checks, out_stat, strain, srna_datas,
                     energy, hit_nr_num, num_strain):
    class_num = 0
    index = {}
    if checks["first"]:
        checks["first"] = False
        class_num = initiate("2d_energy",
                    srna_datas[strain][0].attributes.keys(),
                    "2d_energy", class_num, index, out_stat,
                    " - the normalized(by length of sRNA) free energy change of secondary structure below to " + \
                    str(energy))
        name = " ".join([" - sRNA candidates start with TSS",
               "(3'UTR derived and interCDS sRNA also includes the sRNA candidates which start with processing site.)"])
        class_num = initiate("with_TSS",
                    srna_datas[strain][0].attributes.keys(), "with_TSS",
                    class_num, index, out_stat, name)
        class_num = initiate("nr_hit", srna_datas[strain][0].attributes.keys(),
                    "nr_no_hit", class_num, index, out_stat,
                    "".join([" - blast can not find the homology from nr database (the cutoff is ",
                             str(hit_nr_num), ")."]))
        class_num = initiate("with_term", srna_datas[strain][0].attributes.keys(),
                    "with_term", class_num, index, out_stat,
                    " - sRNA candidates ends with terminator (including the candidates ends with processing site).")
        class_num = initiate("sORF", srna_datas[strain][0].attributes.keys(),
                    "sORF", class_num, index, out_stat,
                    " - have no confliction of sORF candidates.")
        class_num = initiate("sRNA_hit",
                    srna_datas[strain][0].attributes.keys(),
                    "sRNA_no_hit", class_num, index, out_stat,
                    " - blast can not find the homology from sRNA database.")
        class_num = initiate("sRNA_hit",
                    srna_datas[strain][0].attributes.keys(),
                    "sRNA_hit", class_num, index, out_stat,
                    " - blast can find the homology from sRNA database.")
    else:
        out_stat.write("\n")
    if num_strain <= 2:
        out_stat.write("All strains:\n")
        checks["limit"] = True
    else:
        if strain == "all":
            out_stat.write("All strains:\n")
        else:
            out_stat.write(strain + ":\n")
    return class_num, index

def read_file(srna_file):
    strains = []
    checks = {"limit": False, "first": True, "utr": False,
              "inter": False, "in_CDS": False}
    srna_datas = {}
    srna_datas["all"] = []
    strains.append("all")
    pre_seq_id = ""
    fh = open(srna_file)
    for entry in Gff3Parser().entries(fh):
        if entry.source == "UTR_derived":
            checks["utr"] = True
        elif entry.source == "intergenic":
            checks["inter"] = True
        elif entry.source == "in_CDS":
            checks["in_CDS"] = True
        if entry.seq_id != pre_seq_id:
            srna_datas[entry.seq_id] = []
            strains.append(entry.seq_id)
            pre_seq_id = entry.seq_id
        srna_datas[entry.seq_id].append(entry)
        srna_datas["all"].append(entry)
    for strain in srna_datas.keys():
        srna_datas[strain] = sorted(srna_datas[strain],
                             key=lambda k: (k.seq_id, k.start))
    fh.close()
    return srna_datas, strains, checks

def classify_srna(srna_file, out_folder, energy, hit_nr_num,
                  out_stat_file, in_cds):
    srna_datas, strains, checks = read_file(srna_file)
    out_stat = open(out_stat_file, "w")
    for strain in strains:
        if checks["limit"] is True:
            break
        class_num = 0
        if checks["utr"]:
            num_srna = {"total": 0, "intergenic": 0, "5'UTR_derived": 0,
                        "3'UTR_derived": 0, "interCDS": 0}
        else:
            num_srna = {"intergenic": 0}
        if in_cds:
            num_srna["in_CDS"] = 0
        class_num, index = print_stat_title(checks, out_stat, strain, srna_datas,
                                            energy, hit_nr_num, len(strains))
        srna_class = import_data(class_num, srna_datas, index, num_srna, strain,
                                 checks, energy, hit_nr_num)
        for type_, srna in num_srna.items():
            out_stat.write("sRNA type - {0}:\n".format(type_))
            out_stat.write("\ttotal sRNA candidates = {0}\n".format(srna))
            for num in range(1, class_num + 1):
                if srna != 0:
                    out_stat.write("\tclass {0} = {1}({2})\n".format(
                             num, len(srna_class[type_]["class_" + str(num)]),
                             float(len(srna_class[type_]["class_" + str(num)])) / float(srna)))
                elif srna == 0:
                    out_stat.write("\tclass {0} = {1}({2})\n".format(
                             num, len(srna_class[type_]["class_" + str(num)]), 0))
                if type_ == "total":
                    out = open(os.path.join(out_folder,
                               "_".join(["class",
                               str(num), strain + ".gff"])), "w")
                    out.write("##gff-version 3\n")
                    for data in srna_class[type_]["_".join(["class", str(num)])]:
                        out.write(data.info + "\n")
            if class_num >= 2:
                for comb in range(2, class_num):
                    for keys in itertools.combinations(srna_class[type_].keys(), comb):
                        if (("class_" + str(index["sRNA_hit"])) in keys) and (
                            ("class_" + str(index["sRNA_no_hit"])) in keys):
                            continue
                        else:
                            keys = sort_keys(list(keys))
                            gff_name = os.path.join(out_folder,
                                       "_".join(sorted(list(keys)) + \
                                                [strain]) + ".gff")
                            print_intersection(srna_class[type_], keys,
                                srna, gff_name, type_, out_stat)
    out_stat.close()
