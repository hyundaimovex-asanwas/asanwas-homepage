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
	
	// 문자열에 대하여 NULL을 체크하여 "" 을 반환한다  
	public static String nullCheckStr(String value) {
		if (value == null || "".equals(value) || value.length() <= 0 || "null".equals(value) ) {	//문자열 null 체크 부분 추가 by 동현 2014-07-03
			value = "";
		}
		return value;
	}
	
	// 문자열에 대하여 NULL을 체크하여 0 을 반환한다  
	public static int nullCheckNum(String value) {
		int result = 0;
		if (value == null || "".equals(value) || value.length() <= 0 || "null".equals(value) ) {	//문자열 null 체크 부분 추가 by 동현 2014-07-03
			result = 0;
		} else {
			result = Integer.parseInt(value);
		}
		return result;
	}	
	
	public static int convertNum(String value) {
		return Integer.parseInt(value);
	}
	
	
	//2008-01-21 추가 심동현 from mtkumgang.com 
	/** 페이지 바로가기 출력 - first,next,prev,last 버튼 모두 보임 <br>
	 * argument : 
	 * @param page:현재 페이지, allPage:전체 페이지 숫자 , position:현재의 블록에서의 위치, 
	 *        url: 링크 URL, width: 테이블 크기, parameter: 기타 필요한 파라미터들
	 *        imagePath: 이미지위치 ,blockPerPage:  한 블럭 당  페이지 숫자 
	 * @ author : 임형수 
	 * @ E-mail : hslim@imjk.com<br>
	 * 
	 * 수정 : 2008-09-03 음..페이지 이동시 검색어(한글)가 깨지므로 함수변경.
	 * javascript:goPage("+requestedPage+","+position+")
	 */
	public synchronized static String doPageCut(int page, int allPage, int position, String url, String width, String parameter, String imagePath, int blockPerPage){
	StringBuffer sb = new StringBuffer("");
	sb.append("<table border=0 cellpadding=0 cellspacing=0 width="+width+">\n<tr><td height=30 align=center valign=middle class=bodytxt1>");

		int firstPage = (page - (blockPerPage + position)) + 1; //  이전 블럭(<<) 의 최초 페이지 번호
		int lastPage = page + (blockPerPage - position) + 1; //다음 블럭(>>)의 최초 페이지 번호

		int tempPosition = 0;
		
		//System.out.println("page :"+page);
		//System.out.println("allPage :"+allPage);
		//System.out.println("firstPage :"+firstPage);
		//System.out.println("lastPage :"+lastPage);
		//System.out.println("blockPerPage :"+blockPerPage);
		//System.out.println("position :"+position);

		   // 이전 블럭  이동
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
			
			// 이전 페이지  이동
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
            
		// 페이지 숫자 출력
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
		
		//다음 페이지 이동
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
		
		//다음 블록 이동
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
