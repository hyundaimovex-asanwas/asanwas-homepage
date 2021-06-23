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
         // ���� ���ڿ��� null���� �˻�
         if(line == null ) return line;
         // �������ڿ��� �������� �˻�
         if(line.equals("")) return line;
         // ��ü ���ڿ��� �������� �˻�
         if(oldString.equals(newString)) return line;
         // ã�¹��ڿ��� �������� �˻�
         if(oldString.equals("")) return line;
         // ��ü ���ڿ��� ���� ���ڿ��� �����ϰ� �ִ��� �˻�
         if(newString.indexOf(oldString) != -1 && newString.length() > oldString.length()){
             line = replace(line, oldString, "��");
             line = replace(line, "��", newString);
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
     * ����Ű �տ� " > "�� ���� �亯�� �ϴµ� ����Ѵ�.<br>
     *
     * @ author : ������ 
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
    
   
     
    
    /** ������ �ٷΰ��� ��� - first,next,prev,last ��ư ��� ���� <br>
     * argument : 
     * @param page:���� ������, allPage:��ü ������ ���� , position:������ ��Ͽ����� ��ġ, 
     *        url: ��ũ URL, width: ���̺� ũ��, parameter: ��Ÿ �ʿ��� �Ķ���͵�
     *        imagePath: �̹�����ġ ,blockPerPage:  �� �� ��  ������ ���� 
     * @ author : ������ 
     * @ E-mail : hslim@imjk.com<br>
     * 
     */
    public synchronized static String doPageCut
    (int page, int allPage, int position, String url, 
     String width, String parameter, String imagePath, int blockPerPage){
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
	              .append("?page="+firstPage+"&position=1&")
	              .append(parameter)
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
            
        // ������ ���� ���
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
		
		//���� ������ �̵�
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
		
		//���� ��� �̵�
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
     * ���Ͱ��� <BR> �ױ׷� ��ȯ�ϴ� �޼ҵ� <br>
     * : �Խ����� ���� ��ȸ�� <pre> �ױ׸� ������� �ʾ����� �������� �ذ�<br>
     *
     * @ author : ������ 
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
    		// ���� �����͸� ���̱׷��̼� �� ������ ���Ͱ��� �˻��ϱ� ���� �����Ͽ���.
    		// cgi �� �����͸� ������ : \n
    		// �ڹٷ� �����͸� ������ :\r\n
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
     * �Խ��� ����Ʈ���� ���콺 ������ ������ ���̰��ϴ� ��ũ��Ʈ���� ' �� " ���ڰ� ���� �ȵǴϱ� ���ֹ����� �޼ҵ�.^^ <br>
     * : Statement �� �Ἥ �������� ���� ������ ������ ����ϸ� �����Ұ� ����.(�غ��� �ʾ���) <br>
     *
     * @ author : ������ 
     * @ E-mail : sim11@chollian.net
     * 
     */
    public static String replaceQuote(String str){
        String value = str.replace((char)39, '��');
        value = value.replace('"','��');
        return value;
    }
    
    /**
     * �ڹٽ�ũ��Ʈ�� ������ ������ ���ٷ� ������ �ϴ� �޼ҵ�.<br>
     * : ���ٷ� �Ѿ�� �ڹٽ�ũ��Ʈ ������ �߻��ϱ� ������ �� ������ �ذ� <br>
     * : �ؽ�Ʈ ���̸� ������ ũ�⸸ŭ �����ϰ� ��. <br>
     * 
     * @ author : ������ 
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
     * @author ���½�
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
    				msg = "������ ó���� ������ �߻��Ͽ����ϴ�.";	
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
    	// �������� ��ȣ�� ��� �������� ����
    	if(all_page >1){
    		boolean before = page > MAX_SHOW; // [����] �������� �ִ��� �˻�
    		boolean after = ((MAX_SHOW - position) + page) < all_page; // [����] �������� �ִ��� �˻�
    		int firstPage = 1; // [����]�� ������ ��ȣ
    		int lastPage = page + (MAX_SHOW - position) + 1; //[����]�� ������ ��ȣ
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
    	// �������� ��ȣ�� ��� �������� ����
    	if(all_page >1){
    		boolean before = page > MAX_SHOW; // [����] �������� �ִ��� �˻�
    		boolean after = ((MAX_SHOW - position) + page) < all_page; // [����] �������� �ִ��� �˻�
    		int firstPage = 1; // [����]�� ������ ��ȣ
    		int lastPage = page + (MAX_SHOW - position) + 1; //[����]�� ������ ��ȣ
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
    	// �������� ��ȣ�� ��� �������� ����
    	if(all_page >1){
    		boolean before = page > MAX_SHOW; // [����] �������� �ִ��� �˻�
    		boolean after = ((MAX_SHOW - position) + page) < all_page; // [����] �������� �ִ��� �˻�
    		int firstPage = 1; // [����]�� ������ ��ȣ
    		int lastPage = page + (MAX_SHOW - position) + 1; //[����]�� ������ ��ȣ
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
