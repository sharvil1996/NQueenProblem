package com.controller;

import java.util.*;
import java.io.*;
import com.controller.json.simple.JSONObject;

public class NQueens {
	static int[] result;  // stores the result
	static int cnt = 0, onlySolutionCnt = 0; // counters for number of nodes
	static JSONObject obj; // object to store nodes of the tree
	static JSONObject edges; // object to store edges between nodes (define parent-child relationship)
	static JSONObject onlySolution; // object to store only solution (when tree is not demanded)
	
	/*
	 * Below method will check that whether queen at x2 row can be placed at y2 column
	 * We have to check columns for all previous rows
	 * */
	public boolean canPlace(int x2, int y2) {
		/* To validate diagonal : |i-x2| == |result[i]-y2| 
		 *  current row - desired row == i.e. existing column of result array at index i - desired column
		 * */
		for (int i = 0; i < x2; i++) {
			if ((result[i] == y2) || (Math.abs(i - x2) == Math.abs(result[i] - y2))) {
				return false;
			}
		}
		return true;
	}

	public void placeQueens(int x, int size, boolean allNodes) {
		/* Change i to shift desired column to place queen x */
		for (int i = 0; i < size; i++) {
			if (canPlace(x, i)) {
				result[x] = i; // queen can be placed at row x and column i
				for (int k = x + 1; k < size; k++) {
					result[k] = -1; //reinitialize array from the current queen index
				}
				/* this branch is selected if only solution is desired, not entire tree */
				if (!allNodes && x == size - 1) {
					onlySolution.put(++onlySolutionCnt, Arrays.toString(result));
				} else {
					/* this branch is selected if entire tree is desired */
					obj.put(++cnt, Arrays.toString(result) + ":" + x); // put current array position in the tree
					if (x == 0) // all nodes will have the root as a parent if the queen is at 0th row
						edges.put(cnt - 1, 0 + ":" + cnt + ":" + x);
					else {
						/* find the parent of the current node. Go up until you get the parent
						 * the branch is selected if parent is not immediate node
						 * */
						if (Integer.parseInt(String.valueOf(edges.get(cnt - 2)).split(":")[2]) >= x) {
							int temp = 0;
							while (true) {
								if (Integer.parseInt(String.valueOf(edges.get(cnt - 2 - temp)).split(":")[2]) == x) {
									edges.put(cnt - 1,
											(Integer.parseInt(String.valueOf(edges.get(cnt - 2 - temp)).split(":")[0])
													+ ":" + cnt + ":" + x));
									break;
								}
								temp++;
							}
						} 
						/* this branch is selected if immediate node is the parent */
						else
							edges.put(cnt - 1, (cnt - 1 + ":" + cnt + ":" + x));
					}
				}/* try to put next queen */
				placeQueens(x + 1, size, allNodes);
			}
		}
	}

	public static JSONObject[] getSolution(int size, boolean allNodes) {
		JSONObject[] solution = new JSONObject[2];
		obj = new JSONObject();
		edges = new JSONObject();
		onlySolution = new JSONObject();
		cnt = -1;
		onlySolutionCnt = -1;
		int n = size;
		result = new int[n];
		for (int i = 0; i < n; i++)
			result[i] = -1;
		obj.put(++cnt, Arrays.toString(result));
		NQueens i = new NQueens();
		i.placeQueens(0, n, allNodes);
		if (allNodes) {
			/* if entire tree is desired */
			solution[0] = obj;
			solution[1] = edges;
		} else {
			/* only solution is desired */
			solution[0] = onlySolution;
			solution[1] = null;
		}
		return solution;
	}

}