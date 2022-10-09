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

def mask_calulate(bwlist):
    err_limit = 0.01
    while maskcal_sum(bwlist, err_limit):
        err_limit +=0.01

    err_limit = 0.01
    while maskcal_max(bwlist, err_limit):
        err_limit +=0.01


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
