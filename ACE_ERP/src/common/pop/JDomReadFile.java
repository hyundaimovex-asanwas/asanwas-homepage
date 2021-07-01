/*
 * 작성된 날짜: 2011-05-30
 *
 */
package common.pop;

/**
 * @author sdh
 *
 */
import java.io.*;
import java.util.*;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

public class JDomReadFile {

	 public JDomReadFile() {
	 }
	
	 public void returnXMLList(String xmlUrl) throws Exception{
		  SAXBuilder oBuilder = new SAXBuilder();
		  Document oDoc = oBuilder.build(new File(xmlUrl));
		
		  Element xmlRoot = oDoc.getRootElement(); // root element
		  List trackListList = xmlRoot.getChildren(); // root element -> List : trackList
		  Element trackListEle = null; // trackList
		  Element trackEle = null; // track
		  Element memberEle = null; // member

		  for (int i = 0; i < trackListList.size(); i++) { // trackList 
			   trackListEle = (Element) trackListList.get(i); 
			   List trackList = trackListEle.getChildren();
			   
			   for (int j = 0; j < trackList.size(); j++) { // track
					trackEle = (Element) trackList.get(j);
					System.out.println("--TRACK--");
					     
					List memberList = trackEle.getChildren();
	
					for (int k = 0; k < memberList.size(); k++) { // member
						 memberEle = (Element) memberList.get(k);
						 //System.out.println(memberEle.getName()+":"+memberEle.getValue());
					}
			   }
		  }
	
	 }
}



