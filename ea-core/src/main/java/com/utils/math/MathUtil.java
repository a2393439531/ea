package com.utils.math;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class MathUtil {

	public static List<Integer> generateRmdNum(int start, int end, int count) {
		Random r = new Random();
		List<Integer> num = new ArrayList<Integer>();
		int k = 0;
		for (int i = 0; i < count; i++) {
			int p = r.nextInt(end) + start;
			for (int j = 0; j < num.size(); j++) {
				if (num.get(j) == p) {
					k++;
					break;
				}
			}
			if (k >= 1) {
				i--;
				k = 0;
				continue;
			}
			num.add(p);
		}
		return num;
	}
	
}
