extends Node

var waves_data = {
	# key [medium, big, fast, exp, dom]
	# 0~10 Probing Attacks
	1: [1],
	2: [2], #stagerred
	3: [3], #stagerred
	4: [1],
	5: [2], #stagerred
	6: [3], #stagerred
	7: [4], #stagerred
	8: [6], #stagerred
	9: [4], #clump
	10: [0,0,1],
	# 11~20 Light Attacks 
	11: [0,0,3], #stagerred
	12: [2,0,3],
	13: [6,0,1], #stagerred
	14: [9], #stagerred
	15: [4,0,4], #clump
	16: [11], #stagerred
	17: [5,0,5], #clump
	18: [0,0,12], #stagerred
	19: [6,0,6], #clump
	20: [0,0,0,2], #stagerred
	# 21~30 Exploders Live
	21: [7,0,7], #stagerred
	22: [8,0,8], #stagerred
	23: [10,0,10], #stagerred
	24: [6,0,6,4], #clump
	25: [4,0,12,4], #stagerred
	26: [14], #clump
	27: [14,0,14], #stagerred
	28: [0,0,0,10], #clump
	29: [15,0,15,6], #stagerred
	30: [18,1], #stagerred
	# 31~40 Heavy Assault
	31: [20,0,20,2], #stagerred
	32: [0,1,30,4], #stagerred
	33: [30,0,0,4], #stagerred
	34: [10,1,10], #clump
	35: [4,0,12,4], #stagerred
	36: [0,2,0,8], #clump
	37: [25,0,25], #stagerred
	38: [0,4], #clump
	39: [15,0,15,6], #stagerred
	40: [1,1,1,1,1], #stagerred
	
	# 41~50 Final Push
	41: [0,6], #stagerred
	42: [0,8,20], #stagerred
	43: [20,8,10], #stagerred
	44: [10,1,10], #clump
	45: [20,0,0,10,3], #stagerred
	46: [30,4], #clump
	47: [20,0,0,10,6], #stagerred
	48: [0,6,0,20], #clump
	49: [20,12,10,6,4], #stagerred
	50: "Boss"
}
