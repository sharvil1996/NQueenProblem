package com.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.json.simple.JSONObject;

/**
 * Servlet implementation class SolutionServlet
 */
public class SolutionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int size = Integer.parseInt(request.getParameter("size"));
		boolean allNodes = Boolean.valueOf(request.getParameter("allNodes"));
		JSONObject[] solution = NQueens.getSolution(size, allNodes);
		request.setAttribute("obj", solution[0]);
		request.setAttribute("edges", solution[1]);
		response.setContentType("text");
		if (allNodes)
			response.getWriter().write(solution[0].toJSONString() + "*" + solution[1].toJSONString());
		else
			response.getWriter().write(solution[0].toJSONString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
