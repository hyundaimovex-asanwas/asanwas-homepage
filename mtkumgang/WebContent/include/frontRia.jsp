<%@ page language="java" contentType="text/xml; charset=euc-kr"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourFront"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.*"%>
<%
  String strGallery = new String("");
  int board_seq = 0;
  String title = "";
  String move_url = "";
  String type_code = "";
  
  TourFront dao = new TourFront();
  Tbrd_board_ma_bean record []  = dao.getNoticeList();

strGallery="<?xml version=\"1.0\" encoding=\"EUC-KR\" standalone=\"no\"?>";
strGallery = strGallery +  "<FRONT_VIEW>";  
strGallery = strGallery +  "<NOTICE_LIST>";
   
     if (record.length > 0){   
     
         for(int i=0;i< record.length; i++){
          Tbrd_board_ma_bean bean = record[i]; 
          title = bean.getTitle();
          if (title.length() > 20){
             title = title.toString().substring(0,20)+"..";
          }
          strGallery = strGallery +  "<NOTICE_TITLE>"+title+"</NOTICE_TITLE>";
          strGallery = strGallery +  "<NOTICE_URL>/utility/notice/notice_view.jsp?board_seq="+bean.getBoard_seq()+"</NOTICE_URL>";
         }

     }
     
 strGallery = strGallery +  "</NOTICE_LIST>";
 
 
  TourFront dao2 = new TourFront();
  Tbrd_board_ma_bean bean2 = new Tbrd_board_ma_bean();
  Tbrd_board_ma_bean record2 []  = dao.getQuestionList();
  
 strGallery = strGallery +  "<QUESTION_LIST>";
  
      if (record2.length > 0){
   
         for(int j=0;j< record2.length; j++){ 
          Tbrd_board_ma_bean bean = record2[j]; 
          title = bean.getTitle();
          if (title.length() > 20){
             title = title.toString().substring(0,20)+"..";
          }   
          strGallery = strGallery +  "<QUESTION_TITLE>"+title+"</QUESTION_TITLE>";
          strGallery = strGallery +  "<QUESTION_URL><![CDATA[/center/question/question_view.jsp?board_seq="+bean.getBoard_seq()+"&searchTypeCode="+bean.getType_code()+"]]></QUESTION_URL>";
         }
      }
  
  strGallery = strGallery +  "</QUESTION_LIST>";
  
strGallery = strGallery +  "</FRONT_VIEW>";


out.println(strGallery);
%>