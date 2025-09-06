package com.servlet;

import com.dao.DeliveryDAO;
import com.models.Delivery;

import jakarta.servlet.RequestDispatcher;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/DeliveryProgress")
public class DeliveryProgressServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
    private DeliveryDAO deliveryDAO;

    @Override
    public void init() throws ServletException {
        deliveryDAO = new DeliveryDAO(); // Make sure DAO is working
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
    	
    	try {
    	    List<Delivery> deliveries = deliveryDAO.getAllDeliveries();
    	    request.setAttribute("deliveryList", deliveries);
    	} catch(Exception e) {
    	    e.printStackTrace();
    	    throw new ServletException("Error retrieving deliveries", e);
    	    
    	}
        List<Delivery> deliveries = deliveryDAO.getAllDeliveries();

        // Attach the list to the request scope
        request.setAttribute("deliveryList", deliveries);

        // Forward to JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/DeliveryProgress.jsp");
	    dispatcher.forward(request, response);
    }
    
}
