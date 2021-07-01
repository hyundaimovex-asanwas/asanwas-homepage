package kr.co.imjk.util;


public class HtmlUtil{
   /*
    */ 
    
	public static String escapeHtmlString(String s)
     {
         String s1 = s;
         if(s1 == null)
             return null;
         if(s1.indexOf('&', 0) != -1)
             s1 = replace(s1, "&", "&amp;");
         if(s1.indexOf('<', 0) != -1)
             s1 = replace(s1, "<", "&lt;");
         if(s1.indexOf('>', 0) != -1)
             s1 = replace(s1, ">", "&gt;");
         if(s1.indexOf('"', 0) != -1)
             s1 = replace(s1, "\"", "&quot;");
         return s1;
     }
     
     public static String reEscapeHtmlString(String s)
     {
         String s1 = s;
         if(s1 == null)
         {
             return null;
         } else
         {
             String as[] = {
                 "&amp;", "&lt;", "&gt;", "&quot;"
             };
             String as1[] = {
                 "&", "<", ">", "\""
             };
             return replace(s1, as, as1);
         }
     }      
     

     public static String replace(String line, String oldString, String newString){
         // 원본 문자열이 null인지 검사
         if(line == null ) return line;
         // 원본문자열이 공백인지 검사
         if(line.equals("")) return line;
         // 대체 문자열이 동일한지 검사
         if(oldString.equals(newString)) return line;
         // 찾는문자열이 공백인지 검사
         if(oldString.equals("")) return line;
         // 대체 문자열이 원본 문자열을 포함하고 있는지 검사
         if(newString.indexOf(oldString) != -1 && newString.length() > oldString.length()){
             line = replace(line, oldString, "º");
             line = replace(line, "º", newString);
             return line;
         }

         int index=0;
         while((index = line.indexOf(oldString, index)) >= 0){
            line = new StringBuffer()
              .append(line.substring(0, index))
              .append(newString)
              .append(line.substring(index + oldString.length())).toString();
         }
         return line;
     }	
     
     
     public static String replace(String s, String as[], String as1[])
     {
         if(s == null || as == null || as1 == null)
             return s;
         for(int i = 0; i < as.length; i++)
             s = replace(s, as[i], as1[i]);

         return s;
     }	
     
     
     public static String htmlToText(String str)
     {
         if (str==null) return null;
 		String temp = str;
 		temp=strReplace(temp, "<br>", "\n");
 		temp=strReplace(temp, "<Br>", "\n");
 		temp=strReplace(temp, "<BR>", "\n");
 		temp=strReplace(temp, "&nbsp;", " ");
 		temp=strReplace(temp, "&quot;", "\"");
 		temp=strReplace(temp, "&#39;", "'");
 		temp=strReplace(temp, "&gt;", ">");
 		temp=strReplace(temp, "&lt;", "<");
 		temp=strReplace(temp, "&amp;", "&");
 		return temp;
 	}
     
     public static String textToHtml(String str)
     {
         if (str==null) return null;
 		String temp = str;
 		temp=strReplace(temp, " ", "&nbsp;");
 		temp=strReplace(temp, "\"", "&quot;");
 		temp=strReplace(temp, "'", "&#39;");
 		temp=strReplace(temp, ">", "&gt;");
 		temp=strReplace(temp, "<", "&lt;");
 		temp=strReplace(temp, "\n", "<br>");
 		return temp;
     }	     
     
  	public static   String strReplace(String dest,String src,String rep)
    	{
     	String retstr="";
     	String left="";
 		int pos=0;
 		if(dest == null) return retstr;
 		while(true) {
 			if((pos=dest.indexOf(src))!=-1) {
 				left = dest.substring(0, pos);
 				dest = dest.substring(pos+src.length(), dest.length());
 				retstr=retstr+left+rep;
 				pos=pos+src.length();
 			}
 			else {
 				retstr=retstr+dest;
 				break;
 			}
 		}
 		return retstr;
    	}	        
     
     

  	

    /**
     * 엔터키 앞에 " > "를 붙혀 답변을 하는데 사용한다.<br>
     *
     * @ author : 임형수 
     * @ E-mail : sim11@chollian.net<br>
     *
     */
    public static String addGT(String comment){
    	int length = comment.length();
    	StringBuffer buffer = new StringBuffer("> ");		
    	for (int i = 0; i < length; ++i)
    	{
    		String comp = comment.substring(i, i+1);
    		if ("\r".compareTo(comp) == 0)
    		{
    			comp = comment.substring(++i, i+1);
    			if ("\n".compareTo(comp) == 0)
    				buffer.append("\n> ");
    			else
    				buffer.append("\r");
    		}else{
    			buffer.append(comp);
    		}
    	}
    	return buffer.toString();
    }
    
   
     
    
    /** 페이지 바로가기 출력 - first,next,prev,last 버튼 모두 보임 <br>
     * argument : 
     * @param page:현재 페이지, allPage:전체 페이지 숫자 , position:현재의 블록에서의 위치, 
     *        url: 링크 URL, width: 테이블 크기, parameter: 기타 필요한 파라미터들
     *        imagePath: 이미지위치 ,blockPerPage:  한 블럭 당  페이지 숫자 
     * @ author : 임형수 
     * @ E-mail : hslim@imjk.com<br>
     * 
     */
    public synchronized static String doPageCut
    (int page, int allPage, int position, String url, 
     String width, String parameter, String imagePath, int blockPerPage){
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
	              .append("?page="+firstPage+"&position=1&")
	              .append(parameter)
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
              .append("?page=")
              .append(page-1);
              if( (page-1)%blockPerPage  ==0){
                tempPosition = blockPerPage;
              }else{
                tempPosition = (page-1)%blockPerPage;
              }
              sb.append("&position="+tempPosition+"&")
              .append("&")
              .append(parameter)
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
                      .append("?page=")
                      .append(i+1)
                      .append("&position=")
                      .append(nPosition+1)
                      .append("&")
                      .append(parameter)
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
              .append("?page=")
              .append(page+1)
              .append("&position="+(((page)%blockPerPage)+1)+"&")
              .append(parameter)
              .append("\">")
              .append("<img src='"+imagePath+"btn_next.gif'  border='0' align=absmiddle style=margin-top:6px> ")
              .append("</a>");
		}
		
		//다음 블록 이동
		if(lastPage<=allPage){
            sb.append("<a href=\"")
              .append(url)
              .append("?page=") 
              .append(lastPage)
              .append("&position=1&")
              //.append("&position="+((page)%blockPerPage)+"&")
              .append(parameter)
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

	   
    /**
     * 엔터값을 <BR> 테그로 변환하는 메소드 <br>
     * : 게시판의 내용 조회시 <pre> 테그를 사용하지 않았을때 문제점을 해결<br>
     *
     * @ author : 임형수 
     * @ E-mail : sim11@chollian.net
     * 
     */
    public static String htmlBR(String comment){
        if(comment == null) return "&nbsp;";
    	int length = comment.length();
    	StringBuffer buffer = new StringBuffer();
    	
    	for (int i = 0; i < length; ++i)
    	{
    		String comp = comment.substring(i, i+1);
    		// 기존 데이터를 마이그래이션 해 왔을때 엔터값을 검사하기 위해 수정하였음.
    		// cgi 로 데이터를 넣을때 : \n
    		// 자바로 데이터를 넣을때 :\r\n
    		if ("\r".compareTo(comp) == 0 || "\n".compareTo(comp) == 0)
    		{
    		    if("\r".compareTo(comp) == 0){
    			comp = comment.substring(++i, i+1);
    			if ("\n".compareTo(comp) == 0)
                            buffer.append("<BR>\r");
                    }else{
                        buffer.append("<BR>\r");
                    } 
    		}
                buffer.append(comp);
    	}
    	return buffer.toString();
    }
        
    /**
     * 게시판 리스트에서 마우스 오버시 내용을 보이게하는 스크립트에서 ' 와 " 문자가 들어가면 안되니깐 없애버리는 메소드.^^ <br>
     * : Statement 를 써서 쿼리문에 값을 붙혀서 넣을때 사용하면 유용할거 같음.(해보지 않았음) <br>
     *
     * @ author : 임형수 
     * @ E-mail : sim11@chollian.net
     * 
     */
    public static String replaceQuote(String str){
        String value = str.replace((char)39, '′');
        value = value.replace('"','″');
        return value;
    }
    
    /**
     * 자바스크립트로 찍을때 내용이 한줄로 나오게 하는 메소드.<br>
     * : 두줄로 넘어가면 자바스크립트 에러가 발생하기 때문에 이 문제를 해결 <br>
     * : 텍스트 길이를 적당한 크기만큼 리턴하게 함. <br>
     * 
     * @ author : 임형수 
     * @ E-mail : hslim@imjk.co.kr
     * 
     */    
    public static String rmEnter(String comment, int len){
    	int length = comment.length();
    	StringBuffer buffer = new StringBuffer();
    	
    	for (int i = 0; i < length; ++i)
    	{
    		String comp = comment.substring(i, i+1);
    		if ("\r".compareTo(comp) == 0 || "\n".compareTo(comp) == 0)
    		{
    			if(i < (length-1)){
        			comp = comment.substring(++i, i+1);
        			if ("\n".compareTo(comp) == 0)
        				buffer.append("<BR>");
                        }
    		}else{
    		        buffer.append(comp);
    		}
    		if(i == len) {
    		    buffer.append("...");
    		    break;  
                }
    	}
    	return buffer.toString();
    }
    
    /**
     * @author 최태식
     */
    
    public static String jsMsg(String msg,String url,boolean result){
    	
        String jscript ="";
       
        if(result){
    			jscript = new StringBuffer()
    			.append("<script>")
    			.append("alert('")
    			.append(msg)
    			.append("');")
    			.append("location = '")
    			.append(url)
    			.append("';")
    			.append("</script>").toString();
    		}else{

    			if(msg.equals("")){
    				msg = "데이터 처리중 오류가 발생하였습니다.";	
    			}

    			jscript = new StringBuffer()
    			.append("<script>")
    			.append("alert('")
    			.append(msg)
    			.append("');")
    			.append("history.go(-1);")
    			.append("</script>").toString();
    		}

    		return jscript ;
    	}
    
     
    public synchronized static String doPageShortCutWsSamhp(int page, int all_page, int position,int MAX_SHOW, 
		String url, String width, String parameter, String sampi_id, 
		int bbs_id, String class_id, String bbs_auth, String title){
        StringBuffer sb = new StringBuffer("");
    	sb.append("<table border=0 cellpadding=0 cellspacing=0 width="+width+">\n<tr><td height=30 align=center valign=middle class=bodytxt1>");
    	// 페이지를 번호를 몇개씩 보여줄지 지정
    	if(all_page >1){
    		boolean before = page > MAX_SHOW; // [이전] 페이지가 있는지 검사
    		boolean after = ((MAX_SHOW - position) + page) < all_page; // [다음] 페이지가 있는지 검사
    		int firstPage = 1; // [이전]의 페이지 번호
    		int lastPage = page + (MAX_SHOW - position) + 1; //[다음]의 페이지 번호
    		if((page - position) >= MAX_SHOW)
    			firstPage = page - position;
    		if(before)
    			sb.append(" <a href=\"")
                  .append(url)
                  .append("?page=")
                  .append(firstPage)
                  .append("&position=")
                  .append(MAX_SHOW)
                  .append("&")
                  .append(parameter)
				  .append("&sampi_id=")
				  .append(sampi_id)
			      .append("&bbs_id=")
				  .append(bbs_id)
			      .append("&class_id=")
				  .append(class_id)
			      .append("&bbs_auth=")
				  .append(bbs_auth)
			      .append("&title=")
				  .append(title)				  
                  .append("\"><img src=/ws/woorisam/image/common/page_icon_prev.gif align=absmiddle hspace=3 class=marg_b2'> ")
                  .append("</a> ");
    		int nPosition = 0;
    		
    		sb.append("|");
    		for(int i = 0; i	< all_page; i++){				
    		    if(((i+1) > (page - position)) && nPosition < MAX_SHOW){
    		        
    				if(page != (i+1)){
    					sb.append(" <a class=qa01 href=\"")
                          .append(url)
                          .append("?page=")
                          .append(i+1)
                          .append("&position=")
                          .append(nPosition+1)
                          .append("&")
                          .append(parameter)
						  .append("&sampi_id=")
						  .append(sampi_id)
					      .append("&bbs_id=")
						  .append(bbs_id)
					      .append("&class_id=")
						  .append(class_id)
					      .append("&bbs_auth=")
						  .append(bbs_auth)
					      .append("&title=")
						  .append(title)						  
                          .append("\">")
                          .append(i+1)
                          .append("</a> ");
                    }else{
                        sb.append(" <font class=qna_table_blue><b>")
                          .append(i+1)
                          .append("</b></font> ");
                    }    					
    				nPosition ++;
    				sb.append("|");
    			} 
    		}
    		
    		
    		if(after){
    			sb.append(" <a href=\"")
                  .append(url)
                  .append("?page=")
                  .append(lastPage)
                  .append("&position=1&")
                  .append(parameter)
				  .append("&sampi_id=")
				  .append(sampi_id)
			      .append("&bbs_id=")
				  .append(bbs_id)
			      .append("&class_id=")
				  .append(class_id)
			      .append("&bbs_auth=")
				  .append(bbs_auth)
			      .append("&title=")
				  .append(title)				  
                  .append("\"><img src='/ws/woorisam/image/common/page_icon_next.gif' align=absmiddle hspace=3 class=marg_b2>")
                  .append("</a>");
            }
    	}else{
            sb.append("| <font class=qna_table_blue><b>1</b></font> |");
    	}
    	sb.append("</td></tr>\n</table>");
    	return sb.toString();
    } 
    
    
    
    
    public synchronized static String doPageShortCutWsSamhpRe(int page, int all_page, int position,int MAX_SHOW, String url, String width, String parameter, String sampi_id, int bbs_id, String class_id, String bbs_auth, String title, String sub_menu_id){
        StringBuffer sb = new StringBuffer("");
    	sb.append("<table border=0 cellpadding=0 cellspacing=0 width="+width+">\n<tr><td height=30 align=center valign=middle class=bodytxt1>");
    	// 페이지를 번호를 몇개씩 보여줄지 지정
    	if(all_page >1){
    		boolean before = page > MAX_SHOW; // [이전] 페이지가 있는지 검사
    		boolean after = ((MAX_SHOW - position) + page) < all_page; // [다음] 페이지가 있는지 검사
    		int firstPage = 1; // [이전]의 페이지 번호
    		int lastPage = page + (MAX_SHOW - position) + 1; //[다음]의 페이지 번호
    		if((page - position) >= MAX_SHOW)
    			firstPage = page - position;
    		if(before)
    			sb.append(" <a href=\"")
                  .append(url)
                  .append("?page=")
                  .append(firstPage)
                  .append("&position=")
                  .append(MAX_SHOW)
                  .append("&")
                  .append(parameter)
				  .append("&sampi_id=")
				  .append(sampi_id)
			      .append("&bbs_id=")
				  .append(bbs_id)
			      .append("&class_id=")
				  .append(class_id)
			      .append("&bbs_auth=")
				  .append(bbs_auth)
			      .append("&title=")
				  .append(title)
			      .append("&sub_menu_id=")
				  .append(sub_menu_id)                  
                  .append("\"><img src=/ws/woorisam/image/common/page_icon_prev.gif align=absmiddle hspace=3 class=marg_b2'> ")
                  .append("</a> ");
    		int nPosition = 0;
    		
    		sb.append("|");
    		for(int i = 0; i	< all_page; i++){				
    		    if(((i+1) > (page - position)) && nPosition < MAX_SHOW){
    		        
    				if(page != (i+1)){
    					sb.append(" <a class=qa01 href=\"")
                          .append(url)
                          .append("?page=")
                          .append(i+1)
                          .append("&position=")
                          .append(nPosition+1)
                          .append("&")
                          .append(parameter)
						  .append("&sampi_id=")
						  .append(sampi_id)
					      .append("&bbs_id=")
						  .append(bbs_id)
					      .append("&class_id=")
						  .append(class_id)
					      .append("&bbs_auth=")
						  .append(bbs_auth)
					      .append("&title=")
						  .append(title)
					      .append("&sub_menu_id=")
						  .append(sub_menu_id)		  
                          .append("\">")
                          .append(i+1)
                          .append("</a> ");
                    }else{ 
                        sb.append(" <font class=qna_table_blue><b>")
                          .append(i+1)
                          .append("</b></font> ");
                    }    					
    				nPosition ++;
    				sb.append("|");
    			} 
    		}
    		
    		if(after){
    			sb.append(" <a href=\"")
                  .append(url)
                  .append("?page=")
                  .append(lastPage)
                  .append("&position=1&")
                  .append(parameter)
				  .append("&sampi_id=")
				  .append(sampi_id)
			      .append("&bbs_id=")
				  .append(bbs_id)
			      .append("&class_id=")
				  .append(class_id)
			      .append("&bbs_auth=")
				  .append(bbs_auth)
			      .append("&title=")
				  .append(title)
			      .append("&sub_menu_id=")
				  .append(sub_menu_id)               
                  .append("\"><img src='/ws/woorisam/image/common/page_icon_next.gif' align=absmiddle hspace=3 class=marg_b2>")
                  .append("</a>");
            }
    	}else{ 
            sb.append("| <font class=qna_table_blue><b>1</b></font> |");
    	}
    	sb.append("</td></tr>\n</table>");
    	return sb.toString();
    }     

    
    
    public synchronized static String doPageShortCutWsSamhpReM(int page, int all_page, int position,int MAX_SHOW, String url, String width, String parameter, String sampi_id, int bbs_id, String class_id, String bbs_auth, String title, String sub_menu_id, String menu_id){
        StringBuffer sb = new StringBuffer("");
    	sb.append("<table border=0 cellpadding=0 cellspacing=0 width="+width+">\n<tr><td height=30 align=center valign=middle class=bodytxt1>");
    	// 페이지를 번호를 몇개씩 보여줄지 지정
    	if(all_page >1){
    		boolean before = page > MAX_SHOW; // [이전] 페이지가 있는지 검사
    		boolean after = ((MAX_SHOW - position) + page) < all_page; // [다음] 페이지가 있는지 검사
    		int firstPage = 1; // [이전]의 페이지 번호
    		int lastPage = page + (MAX_SHOW - position) + 1; //[다음]의 페이지 번호
    		if((page - position) >= MAX_SHOW)
    			firstPage = page - position;
    		if(before)
    			sb.append(" <a href=\"")
                  .append(url)
                  .append("?page=")
                  .append(firstPage)
                  .append("&position=")
                  .append(MAX_SHOW)
                  .append("&")
                  .append(parameter)
				  .append("&sampi_id=")
				  .append(sampi_id)
			      .append("&bbs_id=")
				  .append(bbs_id)
			      .append("&class_id=")
				  .append(class_id)
			      .append("&bbs_auth=")
				  .append(bbs_auth)
			      .append("&title=")
				  .append(title)
			      .append("&sub_menu_id=")
				  .append(sub_menu_id)
			      .append("&menu_id=")
				  .append(menu_id)	                  
                  .append("\"><img src=/ws/woorisam/image/common/page_icon_prev.gif align=absmiddle hspace=3 class=marg_b2'> ")
                  .append("</a> ");
    		int nPosition = 0;
    		
    		sb.append("|");
    		for(int i = 0; i	< all_page; i++){				
    		    if(((i+1) > (page - position)) && nPosition < MAX_SHOW){
    		        
    				if(page != (i+1)){
    					sb.append(" <a class=qa01 href=\"")
                          .append(url)
                          .append("?page=")
                          .append(i+1)
                          .append("&position=")
                          .append(nPosition+1)
                          .append("&")
                          .append(parameter)
						  .append("&sampi_id=")
						  .append(sampi_id)
					      .append("&bbs_id=")
						  .append(bbs_id)
					      .append("&class_id=")
						  .append(class_id)
					      .append("&bbs_auth=")
						  .append(bbs_auth)
					      .append("&title=")
						  .append(title)
					      .append("&sub_menu_id=")
						  .append(sub_menu_id)
					      .append("&menu_id=")
						  .append(menu_id)						  
                          .append("\">")
                          .append(i+1)
                          .append("</a> ");
                    }else{ 
                        sb.append(" <font class=qna_table_blue><b>")
                          .append(i+1)
                          .append("</b></font> ");
                    }    					
    				nPosition ++;
    				sb.append("|");
    			} 
    		}
    		 
    		
    		if(after){
    			sb.append(" <a href=\"")
                  .append(url)
                  .append("?page=")
                  .append(lastPage)
                  .append("&position=1&")
                  .append(parameter)
				  .append("&sampi_id=")
				  .append(sampi_id)
			      .append("&bbs_id=")
				  .append(bbs_id)
			      .append("&class_id=")
				  .append(class_id)
			      .append("&bbs_auth=")
				  .append(bbs_auth)
			      .append("&title=")
				  .append(title)
			      .append("&sub_menu_id=")
				  .append(sub_menu_id)
			      .append("&menu_id=")
				  .append(menu_id)	                  
                  .append("\"><img src='/ws/woorisam/image/common/page_icon_next.gif' align=absmiddle hspace=3 class=marg_b2>")
                  .append("</a>");
            }
    	}else{
            sb.append("| <font class=qna_table_blue><b>1</b></font> |");
    	}
    	sb.append("</td></tr>\n</table>");
    	return sb.toString();
    }         
}
