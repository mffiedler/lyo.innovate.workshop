/*******************************************************************************
 * Copyright (c) 2012 IBM Corporation.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * and Eclipse Distribution License v. 1.0 which accompanies this distribution.
 *  
 * The Eclipse Public License is available at http://www.eclipse.org/legal/epl-v10.html
 * and the Eclipse Distribution License is available at
 * http://www.eclipse.org/org/documents/edl-v10.php.
 *
 * Contributors:
 *
 *     Russell Boykin       - initial API and implementation
 *     Alberto Giammaria    - initial API and implementation
 *     Chris Peters         - initial API and implementation
 *     Gianluca Bernardini  - initial API and implementation
 *******************************************************************************/
package org.eclipse.lyo.oslc4j.bugzilla.servlet;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.eclipse.lyo.oslc4j.client.ServiceProviderRegistryURIs;
import org.eclipse.lyo.oslc4j.core.model.ServiceProvider;


public class ServletListener
       implements ServletContextListener
{
	
	private static final String PROPERTY_SCHEME = ServletListener.class.getPackage().getName() + ".scheme";
    private static final String PROPERTY_PORT   = ServletListener.class.getPackage().getName() + ".port";
    private static final String SYSTEM_PROPERTY_NAME_REGISTRY_URI = ServiceProviderRegistryURIs.class.getPackage().getName() + ".registryuri";
    private static final String SYSTEM_PROPERTY_NAME_UI_URI = ServiceProviderRegistryURIs.class.getPackage().getName() + ".uiuri";

	private static final Logger logger = Logger.getLogger(ServletListener.class.getName());

    private static final String HOST = getHost();

	
    public ServletListener()
    {
        super();
    }

	@Override
	public void contextDestroyed(ServletContextEvent servletContextEvent) 
	{
		//No need to de-register - catalog will go away with the web app		
	}

    @Override
    public void contextInitialized(final ServletContextEvent servletContextEvent)
    {
    	String basePath=generateBasePath(servletContextEvent);
    	System.setProperty(SYSTEM_PROPERTY_NAME_REGISTRY_URI, basePath + "/services/catalog/singleton");
    	System.setProperty(SYSTEM_PROPERTY_NAME_UI_URI, basePath );
    	
    }
    
    private static String generateBasePath(final ServletContextEvent servletContextEvent)
    {
        final ServletContext servletContext = servletContextEvent.getServletContext();

        String scheme = System.getProperty(PROPERTY_SCHEME);
        if (scheme == null)
        {
            scheme = servletContext.getInitParameter(PROPERTY_SCHEME);
        }

        String port = System.getProperty(PROPERTY_PORT);
        if (port == null)
        {
            port = servletContext.getInitParameter(PROPERTY_PORT);
        }

        return scheme + "://" + HOST + ":" + port + servletContext.getContextPath();
    }

    private static String getHost()
    {
        try
        {
            return InetAddress.getLocalHost().getCanonicalHostName();
        }
        catch (final UnknownHostException exception)
        {
            return "localhost";
        }
    }





}