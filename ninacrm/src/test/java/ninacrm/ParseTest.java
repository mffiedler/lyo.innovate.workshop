package ninacrm;

import java.net.HttpURLConnection;
import java.net.URL;

import junit.framework.TestCase;

import com.hp.hpl.jena.rdf.model.Model;
import com.hp.hpl.jena.rdf.model.ModelFactory;
import com.hp.hpl.jena.rdf.model.Property;
import com.hp.hpl.jena.rdf.model.Resource;
import com.hp.hpl.jena.rdf.model.Statement;

public class ParseTest extends TestCase {
	
	public void testStuff() {}
	
	public void _testRDFParsing() throws Exception {
		
		try {
			
			String resourceURI = "http://macsnoopdave2010:8080/rio-cm/changerequest/1";
	        URL url = new URL(resourceURI);
	        HttpURLConnection conn = (HttpURLConnection)url.openConnection();
	        conn.setRequestProperty("Accept", "application/rdf+xml");
			
	        Model model = ModelFactory.createDefaultModel();			
			model.read(conn.getInputStream(), resourceURI);
			
			Resource resource = model.getResource(resourceURI);
			
			Property fixedProp = model.getProperty("http://open-services.net/ns/cm#fixed");
			Statement fixed = model.getProperty(resource, fixedProp);
			assertNotNull(fixed);
			System.err.println("Fixed = " + fixed.getString());
			
			Property modifiedProp = model.getProperty("http://purl.org/dc/terms/modified");
			Statement modified = model.getProperty(resource, modifiedProp);
			assertNotNull(modified);
			System.err.println("Modified = " + modified.getString());
						
		} catch (Exception e) {
			e.printStackTrace();
			fail();
		}
	}

}
