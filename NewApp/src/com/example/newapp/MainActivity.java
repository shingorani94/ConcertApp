package com.example.newapp;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;

public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getConcertInformation("/Users/navninder/Documents/workspace/NewApp/states.xml");
        setContentView(R.layout.activity_main);
    }
    static ArrayList<Concerts> concertList;
    private static void getConcertInformation(String stateUrl)
	{
		System.out.println("Received URL = " + stateUrl);
		Document doc = null;
	    try {
			URL url = new URL(stateUrl);
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			doc = db.parse(url.openStream());
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    concertList = new ArrayList<Concerts>();
		NodeList nlist = doc.getElementsByTagName("item");
		for(int i = 0; i<nlist.getLength(); i++)
		{
			Node n = nlist.item(i);
			Element element = (Element)n;
			Concerts dataObject = new Concerts();
			NodeList childnodes = n.getChildNodes();
			for(int j = 0; j<childnodes.getLength(); j++)
			{
				Node childnode = childnodes.item(j);
				String  val = childnode.getTextContent();
				String nodeName = childnode.getNodeName();
				if(childnode.getNodeName().equals("title"))
				{
					System.out.println("title = " + val);
					dataObject.setTitle(val);
				}  
				else if(nodeName.equals("link"))
				{
					System.out.println("link = " + val);
					dataObject.setLink(val);
				} else if(nodeName.equals("description"))
				{
					System.out.println("description = " + val);
					dataObject.setLocation(val);
				} else if(nodeName.equals("pubDate"))
				{
					System.out.println("PubDate = " + val);
					dataObject.setDate(val);
				}
				concertList.add(dataObject);
			}
		}
	}

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }
    
}
