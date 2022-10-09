#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#define AUTO_TEST_ROUND   8
#define BW_PERCENT_MIN    5
#define QUEUE_NUM_MAX     8
#define QUEUE_WEIGHT_MAX  8
#define CALCULATE_LEVEL   4

#define MIN(a, b)   ((a) <= (b) ? (a) : (b))
#define MAX(a, b)   ((a) >= (b) ? (a) : (b))

void dump_queue_config (int queue_num, int *queue_bw_pct);
int generate_queue_config (int *queue_bw_pct);
void calculate_queue_mask (int queue_num, int *queue_bw_pct, unsigned char *queue_mask);


int main (void)
{
    int i, flag, left_pct;
    int queue_num;
    int queue_bw_pct[QUEUE_NUM_MAX];
    unsigned char queue_mask[QUEUE_NUM_MAX];

    printf("\n########################### Anto Test ###########################\n");

    for (i = 0; i < AUTO_TEST_ROUND; i++) {
    	printf("TEST: %u\n", i+1);
    	queue_num = generate_queue_config(&queue_bw_pct[0]);
    	calculate_queue_mask(queue_num, &queue_bw_pct[0], &queue_mask[0]);
    	printf("\n");
    }

    printf("\n########################## Manual Test ##########################\n");

    while (1) {
        printf("\nPlease input the queue number (0 exit): ");
        flag = scanf("%d", &queue_num);
        if (queue_num == 0 || flag != 1) {
        	printf("\n");
        	exit(0);
        } else if (queue_num < 0 || QUEUE_NUM_MAX < queue_num) {
        	printf("Input invalid queue number, please try again.\n");
        	continue;
        }

        left_pct = 100;
        for (i = 0; i < queue_num - 1; i++) {
        	printf("Please input queue[%u] bandwidth percent: ", i + 1);
        	flag = scanf("%d", &queue_bw_pct[i]);
        	if (queue_bw_pct[i] <= 0 || left_pct <= queue_bw_pct[i]) {
        		printf("Input invalid queue bandwidth percent, please try again.\n");
        		break;
        	}
        	left_pct -= queue_bw_pct[i];
        }

        if (i != queue_num - 1) {
        	continue;
        }

        queue_bw_pct[i] = left_pct;
        printf("Get the last queue[%u] bandwidth percent: %u\n\n", i + 1, queue_bw_pct[i]);
        dump_queue_config(queue_num, queue_bw_pct);

    	calculate_queue_mask(queue_num, &queue_bw_pct[0], &queue_mask[0]);
    }
}

void dump_queue_config (int queue_num, int *queue_bw_pct)
{
    int i;

	printf("QoS Config: %u [", queue_num);
    for (i = 0; i < queue_num; i++) {
        printf(" %u%% ", queue_bw_pct[i]);
    }
	printf("]\n");
}

static void
dump_queue_weight (int queue_num, int *queue_weight, float score)
{
    int i, sum = 0;

	printf("Queue Weight: (");
    for (i = 0; i < queue_num; i++) {
    	sum += queue_weight[i];
        printf(" %u ", queue_weight[i]);
    }
	printf(")\n");

	printf("Queue Percent: (");
    for (i = 0; i < queue_num; i++) {
        printf(" %0.2f%% ", queue_weight[i] * 100.0 / sum);
    }
	printf(") Score %f \n", score);
}

static void
dump_queue_mask (int queue_num, unsigned char *queue_mask)
{
    int i, j;

    for (i = 0; i < queue_num; i++) {
        printf("Queue[%u] Mask:", i+1);
        for (j = 0; j < QUEUE_WEIGHT_MAX; j++) {
        	printf(" %u ", queue_mask[i] & (0x1 << j) ? 1 : 0);
        }
        printf("\n");
    }
}


int generate_queue_config (int *queue_bw_pct)
{
	int i;
    int queue_num = 2 + rand() % (QUEUE_NUM_MAX-1);
    int left_percent = 100;
    int percent;

    for (i = 0; i < queue_num; i++) {
        if (left_percent == 0) {
            queue_num = i;
            break;
        }
        if (i == queue_num - 1) {
            percent = left_percent;
        } else {
            percent = BW_PERCENT_MIN + rand() % ((left_percent + 1) / 2);
        }
        if (percent > left_percent - BW_PERCENT_MIN) {
        	percent = left_percent;
        }
        left_percent -= percent;

        queue_bw_pct[i] = percent;
    }

    dump_queue_config(queue_num, queue_bw_pct);

    return queue_num;
}

static void
sort_queue_config (int queue_num, int *queue_bw_pct, int *pos)
{
    int i, j, min, tmp;

    for (i = 0; i < queue_num; i++) {
    	pos[i] = i;
    }

    for (i = 0; i < queue_num; i++) {
    	min = i;
    	for (j = i + 1; j < queue_num; j++) {
    		if (queue_bw_pct[j] < queue_bw_pct[min]) {
    			min = j;
    		}
    	}

    	tmp = queue_bw_pct[i];
    	queue_bw_pct[i] = queue_bw_pct[min];
    	queue_bw_pct[min] = tmp;

    	tmp = pos[i];
    	pos[i] = pos[min];
    	pos[min] = tmp;
    }
}

static float 
score_queue_weight (int queue_num, int *queue_bw_pct, int *queue_weight)
{
    int i;
    float act_pct, err_pct;
    float score = 0;
    int total_weight = 0;

    for (i = 0; i < queue_num; i++) {
        total_weight += queue_weight[i];
    }

    for (i = 0; i < queue_num; i++) {
        act_pct = queue_weight[i] * 100.0 / total_weight;
        err_pct = act_pct - queue_bw_pct[i];
        score += queue_bw_pct[i] - (err_pct * err_pct) / queue_bw_pct[i];
    }

    return score;
}

static void
calculate_queue_weight (int queue_num, int *queue_bw_pct, int *queue_weight, int index, float *bst_score, int *bst_weight, int used_w, int used_p)
{
	int i;
	int tmp_w, exp_w, min_w, max_w;
	float score;

	if (queue_num == index) {
		score = score_queue_weight(queue_num, queue_bw_pct, &queue_weight[0]);
        if (score >= *bst_score) {
            *bst_score = score;
            memcpy(&bst_weight[0], &queue_weight[0], queue_num * sizeof(int));
        }
        return;
	}

	exp_w = (used_w * queue_bw_pct[index] + used_p / 2) / used_p;
	min_w = MIN(exp_w - CALCULATE_LEVEL/2, QUEUE_WEIGHT_MAX - CALCULATE_LEVEL);
	min_w = MAX(min_w, queue_weight[index-1]);
	max_w = MIN(min_w + CALCULATE_LEVEL, QUEUE_WEIGHT_MAX);
	max_w = MAX(min_w, max_w);

	for (tmp_w = min_w; tmp_w <= max_w; tmp_w++) {
		queue_weight[index] = tmp_w;
		calculate_queue_weight(queue_num, queue_bw_pct, queue_weight, index + 1, bst_score, bst_weight, used_w + tmp_w, used_p + queue_bw_pct[index]);
	}
}

static unsigned char
get_queue_mask (int weight) {
	switch (weight) {
	case 8:
		return 0xFF;  // 1111 1111
	case 7:
		return 0xEF;  // 1110 1111
	case 6:
		return 0xEE;  // 1110 1110
	case 5:
		return 0xDA;  // 1101 1010
	case 4:
		return 0xAA;  // 1010 1010
	case 3:
		return 0x92;  // 1001 0010
	case 2:
		return 0x88;  // 1000 1000
	case 1:
		return 0x80;  // 1000 0000
	default:
		return 0x80;  // 1000 0000
	}
}

void calculate_queue_mask (int queue_num, int *queue_bw_pct, unsigned char *queue_mask)
{
    int i, j;
    float score;
    float bst_score = -999999.9;
    int pos[QUEUE_NUM_MAX];
    int queue_weight[QUEUE_NUM_MAX];
    int bst_weight[QUEUE_NUM_MAX];
    int tmp_weight[QUEUE_NUM_MAX];
    unsigned char tmp_mask;

    sort_queue_config(queue_num, queue_bw_pct, &pos[0]);

    for (i = 1; i <= QUEUE_WEIGHT_MAX; i++) {
        tmp_weight[0] = i;
        calculate_queue_weight(queue_num, queue_bw_pct, &tmp_weight[0], 1, &bst_score, &bst_weight[0], i, queue_bw_pct[0]);
    }

    for (i = 0; i < queue_num; i++) {
    	queue_weight[pos[i]] = bst_weight[i];
    }

    dump_queue_weight(queue_num, queue_weight, bst_score);

    for (i = 0; i < queue_num; i++) {
    	tmp_mask = get_queue_mask(queue_weight[i]);
    	queue_mask[i] = (tmp_mask >> i) | (tmp_mask << (QUEUE_WEIGHT_MAX - i));
    }

    dump_queue_mask(queue_num, queue_mask);
}