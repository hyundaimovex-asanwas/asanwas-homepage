package sales.common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gauce.GauceContext;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;

public class HDUtil {
	
	// ���ڿ��� ���Ͽ� NULL�� üũ�Ͽ� "" �� ��ȯ�Ѵ�  
	public static String nullCheckStr(String value) {
		if (value == null || "".equals(value) || value.length() <= 0 || "null".equals(value) ) {	//���ڿ� null üũ �κ� �߰� by ���� 2014-07-03
			value = "";
		}
		return value;
	}
	
	// ���ڿ��� ���Ͽ� NULL�� üũ�Ͽ� 0 �� ��ȯ�Ѵ�  
	public static int nullCheckNum(String value) {
		int result = 0;
		if (value == null || "".equals(value) || value.length() <= 0 || "null".equals(value) ) {	//���ڿ� null üũ �κ� �߰� by ���� 2014-07-03
			result = 0;
		} else {
			result = Integer.parseInt(value);
		}
		return result;
	}	
	
	public static int convertNum(String value) {
		return Integer.parseInt(value);
	}
	
	
	//2008-01-21 �߰� �ɵ��� from mtkumgang.com 
	/** ������ �ٷΰ��� ��� - first,next,prev,last ��ư ��� ���� <br>
	 * argument : 
	 * @param page:���� ������, allPage:��ü ������ ���� , position:������ ��Ͽ����� ��ġ, 
	 *        url: ��ũ URL, width: ���̺� ũ��, parameter: ��Ÿ �ʿ��� �Ķ���͵�
	 *        imagePath: �̹�����ġ ,blockPerPage:  �� �� ��  ������ ���� 
	 * @ author : ������ 
	 * @ E-mail : hslim@imjk.com<br>
	 * 
	 * ���� : 2008-09-03 ��..������ �̵��� �˻���(�ѱ�)�� �����Ƿ� �Լ�����.
	 * javascript:goPage("+requestedPage+","+position+")
	 */
	public synchronized static String doPageCut(int page, int allPage, int position, String url, String width, String parameter, String imagePath, int blockPerPage){
	StringBuffer sb = new StringBuffer("");
	sb.append("<table border=0 cellpadding=0 cellspacing=0 width="+width+">\n<tr><td height=30 align=center valign=middle class=bodytxt1>");

		int firstPage = (page - (blockPerPage + position)) + 1; //  ���� ��(<<) �� ���� ������ ��ȣ
		int lastPage = page + (blockPerPage - position) + 1; //���� ��(>>)�� ���� ������ ��ȣ

		int tempPosition = 0;
		
		//System.out.println("page :"+page);
		//System.out.println("allPage :"+allPage);
		//System.out.println("firstPage :"+firstPage);
		//System.out.println("lastPage :"+lastPage);
		//System.out.println("blockPerPage :"+blockPerPage);
		//System.out.println("position :"+position);

		   // ���� ��  �̵�
			if(firstPage<1){
				sb.append("")
				.append("<img src='"+imagePath+"btn_first.gif'  border='0' align=absmiddle style=margin-top:6px> ")
				.append("");
			}else{
				sb.append("<a href=\"") 
				  .append(url)
				  .append("goPage("+firstPage+",1)")
				  //.append(parameter)
				  .append("\"> <img src='"+imagePath+"btn_first.gif' border='0'  align=absmiddle style=margin-top:6px>  </a>  ");
			}
			
			// ���� ������  �̵�
			if(page<=1){
				sb.append("")
				.append("<img src='"+imagePath+"btn_prev.gif'  border='0' align=absmiddle style=margin-top:6px> ")
				.append("");
			}else{
			sb.append("<a href=\"")
			  .append(url)
			  .append("goPage(")
			  //.append("?requestedPage=")
			  .append(page-1);
			  if( (page-1)%blockPerPage  ==0){
				tempPosition = blockPerPage;
			  }else{
				tempPosition = (page-1)%blockPerPage;
			  }
			  sb.append(","+tempPosition+")")
			  //sb.append("&position="+tempPosition+"&")
			  //.append("&")
			  //.append(parameter)
			  .append("\"> ")
			  .append("  <img src='"+imagePath+"btn_prev.gif'  border='0' align=absmiddle style=margin-top:6px> ")
			  .append("</a> ");
			}
            
		// ������ ���� ���
		int nPosition = 0;
		for(int i = 0; i	< allPage; i++){				
			if(((i+1) > (page - position)) && nPosition < blockPerPage){
		        
				if(page != (i+1)){
					sb.append(" <a href=\"")
					  .append(url)
					  .append("goPage(")
					  //.append("?requestedPage=")
					  .append(i+1)
					  .append(",")
					  //.append("&position=")
					  .append(nPosition+1+")")
					  //.append(nPosition+1)
					  //.append("&")
					  //.append(parameter)
					  .append("\">")
					  .append(i+1)
					  .append("</a> ");
				}else{ 
					sb.append(" <b>")
					  .append(i+1)
					  .append("</b> ");
				}    					
				nPosition ++;
			}
		}
		
		//���� ������ �̵�
		if((page+1)>allPage){
			sb.append("")
			.append("<img src='"+imagePath+"btn_next.gif'  border='0' align=absmiddle style=margin-top:6px> ")
			.append("");
		}else{
			sb.append("<a href=\"")
			  .append(url)
			  .append("goPage(")
			  //.append("?requestedPage=")
			  .append(page+1)
			  .append(","+(((page)%blockPerPage)+1)+")")
			  //.append("&position="+(((page)%blockPerPage)+1)+"&")
			  //.append(parameter)
			  .append("\">")
			  .append("<img src='"+imagePath+"btn_next.gif'  border='0' align=absmiddle style=margin-top:6px> ")
			  .append("</a>");
		}
		
		//���� ��� �̵�
		if(lastPage<=allPage){
			sb.append("<a href=\"")
			  .append(url)
			  .append("goPage(")
			  //.append("?requestedPage=") 
			  .append(lastPage)
			  .append(",1)")
			  //.append("&position=1&")
			  //.append(parameter)
			  .append("\"> <img src='"+imagePath+"btn_last.gif' border='0' align=absmiddle style=margin-top:6px> </a> ");
		  }else{
			  sb.append("")
			  .append("<img src='"+imagePath+"btn_last.gif'  border='0' align=absmiddle style=margin-top:6px> ")
			  .append("");
		  }
		

		sb.append("</td></tr>\n</table>");
	
		//System.out.println(sb);
		return sb.toString();
	}
	
	

}
