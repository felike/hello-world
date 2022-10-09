#!/usr/bin/python3
from __future__ import division

def maskcal_max(bwlist, err_limit):
    mask=[8]*len(bwlist)
    bw_sum = sum(bwlist)

    while 1:
        sch_sum = sum(mask)
        per_sch = bw_sum/sch_sum
        idx = 0
        max_err = 0
        max_err_idx = 0
        while idx < len(bwlist):
            err = per_sch*mask[idx] - bwlist[idx]
            if(max_err < err):
                max_err = err
                max_err_idx = idx
            idx += 1
        if max_err < per_sch:
            idx = 0
            sum_dev = 0.0
            max_dev = 0.0
            while idx < len(bwlist):
                dev = abs((bwlist[idx]-per_sch*mask[idx]))/bwlist[idx]
                sum_dev += dev
                if max_dev < dev:
                    max_dev = dev
                idx += 1
            if max_dev <= err_limit:
                print("max check find mask:%s max_err:%.4f sum_err:%.4f" % (mask, max_dev,sum_dev),
                        "expect bw:", bwlist, 
                        "actual bw:", [round(x*per_sch, 4) for x in mask])
                return 0
        mask[max_err_idx] -= 1
        if mask[max_err_idx] == 0:
            return -1

def maskcal_sum(bwlist, err_limit):
    mask=[8]*len(bwlist)
    bw_sum = sum(bwlist)

    while 1:
        sch_sum = sum(mask)
        per_sch = bw_sum/sch_sum
        idx = 0
        max_err = 0
        max_err_idx = 0
        while idx < len(bwlist):
            err = per_sch*mask[idx] - bwlist[idx]
            if(max_err < err):
                max_err = err
                max_err_idx = idx
            idx += 1
        if max_err < per_sch:
            idx = 0
            sum_dev = 0.0
            max_dev = 0.0
            while idx < len(bwlist):
                dev = abs((bwlist[idx]-per_sch*mask[idx]))/bwlist[idx]
                sum_dev += dev
                if max_dev < dev:
                    max_dev = dev
                idx += 1
            if sum_dev <= err_limit:
                print("sum check find mask:%s max_err:%.4f sum_err:%.4f" % (mask, max_dev,sum_dev),
                        "expect bw:", bwlist, 
                        "actual bw:", [round(x*per_sch, 4) for x in mask])
                return 0
        mask[max_err_idx] -= 1
        if mask[max_err_idx] == 0:
            return -1

def maskcal_sample(bwlist):
    bw_sum = sum(bwlist)
    bw_max = max(bwlist)
    max_mask_list = [5,6,7,8]
    max_dev_list = 4*[None]
    sum_dev_list = 4*[None]
    mask_list = 4*[None]
    list_idx = 0

    while list_idx < len(max_mask_list):
        mask=[8]*len(bwlist)
        max_sch = max_mask_list[list_idx]
        per_sch = bw_max/max_sch

        idx = 0
        while idx < len(bwlist):
            mask[idx] =  round(bwlist[idx]/per_sch)
            idx += 1
        
        sch_sum = sum(mask)
        per_sch = bw_sum/sch_sum
        sum_dev = 0.0
        max_dev = 0.0
        idx = 0
        while idx < len(bwlist):
            dev = abs((bwlist[idx]-per_sch*mask[idx]))/bwlist[idx]
            idx += 1
            sum_dev += dev
            if max_dev < dev:
                max_dev = dev
        max_dev_list[list_idx] = max_dev
        sum_dev_list[list_idx] = sum_dev
        mask_list[list_idx] = mask
        list_idx +=1

    list_idx = 0
    idx = 0
    min_err = 100
    while list_idx < len(max_mask_list):
        if min_err > sum_dev_list[list_idx]:
            min_err = sum_dev_list[list_idx]
            idx = list_idx
        list_idx += 1
    sum_sch = sum(mask_list[idx])
    per_sch = bw_sum/sum_sch
    print("felike sum check find mask:%s max_err:%.4f sum_err:%.4f" %
            (mask_list[idx], max_dev_list[idx],sum_dev_list[idx]),
          "expect bw:", bwlist, 
          "actual bw:", [round(x*per_sch, 4) for x in mask_list[idx]])

    list_idx = 0
    idx = 0
    min_err = 100
    while list_idx < len(max_mask_list):
        if min_err > max_dev_list[list_idx]:
            min_err = max_dev_list[list_idx]
            idx = list_idx
        list_idx += 1
    sum_sch = sum(mask_list[idx])
    per_sch = bw_sum/sum_sch
    print("felike max check find mask:%s max_err:%.4f sum_err:%.4f" %
            (mask_list[idx], max_dev_list[idx],sum_dev_list[idx]),
          "expect bw:", bwlist, 
          "actual bw:", [round(x*per_sch, 4) for x in mask_list[idx]])
    print("\n\n")

def mask_calulate(bwlist):
    err_limit = 0.01
    while maskcal_sum(bwlist, err_limit):
        err_limit +=0.01

    err_limit = 0.01
    while maskcal_max(bwlist, err_limit):
        err_limit +=0.01
    maskcal_sample(bwlist)


bwlist=[21,12,16,16]
mask_calulate(bwlist)
    
bwlist=[63,9,9]
mask_calulate(bwlist)

bwlist=[36,24,6]
mask_calulate(bwlist)

bwlist=[31,12,19]
mask_calulate(bwlist)

bwlist=[33,21,7,16,14]
mask_calulate(bwlist)

bwlist=[33,11,7,16,14]
mask_calulate(bwlist)
