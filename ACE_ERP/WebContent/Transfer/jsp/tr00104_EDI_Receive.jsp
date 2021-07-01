<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산  OMS
+ 프로그램 ID	: TR00202.HTML
+ 기 능 정 의	: 반입주문등록
+ 변 경 이 력	: 정미선
+ 서 블 릿 명	: TR00202.HTML
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 :
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 :
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="transfer.common.*"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 및 기타 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());
%>


<!-- HTML 시작-->
<html>
	<head>
   <jsp:include page="/Transfer/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script 시작
=============================================================================*/
%>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcDs1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDsgetdate classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT><%=HDConstant.COMMENT_END%><!-- 차량종류 -->

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT><%=HDConstant.COMMENT_END%><!-- 반입반출 -->

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT><%=HDConstant.COMMENT_END%><!-- EDI 수신 -->

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT><%=HDConstant.COMMENT_END%><!-- EDI 수신 -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcDs7 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT><%=HDConstant.COMMENT_END%><!-- EDI 수신 -->

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs8 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT><%=HDConstant.COMMENT_END%><!-- EDI 수신 -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcDs9 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT><%=HDConstant.COMMENT_END%><!-- EDI 수신 -->

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id="gcTr01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--주문 마스터-->
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- /******************************************************************************
	Description : Java Script 
******************************************************************************/ --> 
<SCRIPT language=JavaScript>

	var strParam = new Array();
  strParam=window.dialogArguments;

	/******************************************************************************
		Description :
	******************************************************************************/
	function ln_Start(){

	  if(strParam[0]=="A") gclx_gubun.bindcolval=1; //주문배정
		else if(strParam[0]=="B") gclx_gubun.bindcolval=2; //배차
		else if(strParam[0]=="C") gclx_gubun.bindcolval=3; //입고
		else if(strParam[0]=="D") gclx_gubun.bindcolval=4; //상차

		ln_Grid_Format();

		gcDs2.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0002";  //Project 
		gcDs2.Reset();

		gcDs3.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>com_ltcode?v_str1=0003";  //적재구분 
		gcDs3.Reset();

		gcDs4.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>com_ltcode?v_str1=0011";  //적재구분 
		gcDs4.Reset();	

		gcrd_sendgb.codevalue=1; //일괄수신
		ln_Enable();

		if(location.search){
			var str0=location.search.split("&")[0];
			var str1=location.search.split("&")[1];
			var str2=location.search.split("&")[2];
			var str3=location.search.split("&")[3];
		}

		if (str2=="" || str2==undefined){

			gcDsgetdate.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsGetDates?NOH=Y&v_str1=0001";  //Project 
			gcDsgetdate.Reset() ;

			if(gcDsgetdate.CountRow > 0 ) gcem_edt_dt.Text =  gcDsgetdate.NameValue(1,"APP_DT1");
		} else {

			gcem_edt_dt.Text	= str3;	
		}
		
		gclx_edi_sts.index=1;
		gclx_in_out.index=0;
		gclx_ing_sts.index=0;

	
	}

	/******************************************************************************
		Description : 조회
	******************************************************************************/
	function ln_Query(){

    if(gclx_gubun.bindcolval==""){
			alert("수신 팝업을 다시 띄우세여. EDI 구분이 존재하지 않습니다.");
			return false;
		}

		var ls_data = "?v_str0=" + gclx_line_part.bindcolval //프로젝트
								+ "&v_str1=" + gclx_gubun.bindcolval     //EDI구분 - 주문배정
								+ "&v_str2=" + gcem_edt_dt.Text          //반출일자
								+ "&v_str3=" + gclx_edi_sts.bindcolval   //수신여부
								+ "&v_str4=" + gclx_in_out.bindcolval    //반출입구분
								+ "&v_str5=" + gclx_ing_sts.bindcolval;  //상태구분

		if(gclx_gubun.bindcolval==1){	 //주문배정

			gcDs1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00104_edi_2_r" + ls_data;

			gcDs1.Reset();
		}else if(gclx_gubun.bindcolval==2){ //배차
			gcDs1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00104_edi_3_r" + ls_data;

			gcDs1.Reset();
  	}else if(gclx_gubun.bindcolval==3){ //입고
			gcDs1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00104_edi_4_r" + ls_data;

			gcDs1.Reset();
		}else if(gclx_gubun.bindcolval==4){ //상차
			gcDs1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00104_edi_5_r" + ls_data;

			gcDs1.Reset();
    }	
	}


  /******************************************************************************
		Description : 
	******************************************************************************/
	function ln_Grid_Format(){
    
		 if(gclx_gubun.bindcolval==1){	 //주문배정
			 gcgd_data.Format = "<FC> Name='No.'	      ID=GRAYY         HeadAlign=Center HeadBgColor=#eeeeee Width=28  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} Value={ToString(RowCount-CurRow+1)}</FC>                                     "  
												+ "<FC> Name='선택'	      ID=CHK  		     HeadAlign=Center	HeadBgColor=#eeeeee Width=28  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} Editstyle='checkbox' cursor=hand</FC>                                        "  
												+ "<FC> Name='구분'	      ID=INGGB   	     HeadAlign=Center	HeadBgColor=#eeeeee Width=58  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} suppress=1</FC>                                                              "  
												+ "<FG> Name='EDI공용DB'  HeadAlign=Center HeadBgColor=#eeeeee                                                                                                                                                                               "  
												+ "	<FC> Name='전송수신'  ID=HL_EDI_STS	   HeadAlign=Center	HeadBgColor=#eeeeee Width=62  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} EditStyle=Combo Data='N:미수신,S:수신중,Y:수신완료,A:재수신' suppress=2</FC> "  
												+ "	<FC> Name='상태'	    ID=HL_ING_STS	   HeadAlign=Center	HeadBgColor=#eeeeee Width=30  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} EditStyle=Combo Data='I:신규,U:수정,C:취소' suppress=3</FC> 				         "  
												+ "</FG>                                                                                                                                                                                                                                     "  
												+ "<FC> Name='반출일자'	  ID=ETD_DT		     HeadAlign=Center	HeadBgColor=#eeeeee Width=68  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} MASK='XXXX/XX/XX' , suppress=4</FC>                                          "  
												+ "<FC> Name='주문번호'	  ID=ORDER_NO	     HeadAlign=Center	HeadBgColor=#eeeeee Width=68  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} suppress=5</FC>                                                              "  
												+ "<FC> Name='배정번호'	  ID=CAR_SEQ_NO	   HeadAlign=Center	HeadBgColor=#eeeeee Width=68  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} suppress=6</FC>                                                              "  
												+ "<FC> Name='차량종류'	  ID=CARGO_TYPE	   HeadAlign=Center	HeadBgColor=#eeeeee Width=100 align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} suppress=7  EditStyle=Lookup	Data='gcDs3:MINORCD:MINORNM' show=false</FC>   "  
												+ "<FC> Name='화주'		    ID=SHIPPERNM     HeadAlign=Center	HeadBgColor=#eeeeee Width=110 align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} suppress=8</FC>                                                              "  
												+ "<C> Name='품명'			  ID=ARTC_NM  	   HeadAlign=Center	HeadBgColor=#eeeeee Width=110 align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C>                                                                         "  
												+ "<C> Name='상차지'		  ID=LD_CARGO_NM   HeadAlign=Center	HeadBgColor=#eeeeee Width=70  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C>                                                                         "  
												+ "<C> Name='상차지상세'	ID=LD_CARGONM	   HeadAlign=Center	HeadBgColor=#eeeeee Width=120 align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C>                                                                         "  
												+ "<C> Name='하차지'		  ID=OFF_CARGO_NM  HeadAlign=Center	HeadBgColor=#eeeeee Width=70  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C>                                                                         "  
												+ "<C> Name='하차지상세'	ID=OFF_CARGONM   HeadAlign=Center	HeadBgColor=#eeeeee Width=120 align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C>                                                                         "  
												+ "<C> Name='송하인TEL'	  ID=SHIPPERTEL	   HeadAlign=Center	HeadBgColor=#eeeeee Width=90  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C>                                                                         "  
												+ "<C> Name='송하인HP'	  ID=SHIPPERHP	   HeadAlign=Center	HeadBgColor=#eeeeee Width=90  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C>                                                                         "  
												+ "<C> Name='수하인TEL'	  ID=RECP_TEL  	   HeadAlign=Center	HeadBgColor=#eeeeee Width=90  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C>                                                                         " 
		 }else if(gclx_gubun.bindcolval==2){ //배차
		   gcgd_data.Format = "<FC> Name='No.'	      ID=''            HeadAlign=Center HeadBgColor=#eeeeee Width=25  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} Value={ToString(RowCount-CurRow+1)}</FC>                                     "  
												+ "<FC> Name='선택'	      ID=CHK  		     HeadAlign=Center	HeadBgColor=#eeeeee Width=25  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} Editstyle='checkbox' cursor=hand</FC>                                        "  
			                  + "<FG> Name='EDI공용DB'  HeadAlign=Center HeadBgColor=#eeeeee                                                                                                                                                                               "  
												+ "	<FC> Name='전송수신'  ID=HL_EDI_STS	   HeadAlign=Center	HeadBgColor=#eeeeee Width=62  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} EditStyle=Combo Data='N:미수신,S:수신중,Y:수신완료,A:재수신' suppress=1</FC> "  
												+ "	<FC> Name='상태'	    ID=HL_ING_STS	   HeadAlign=Center	HeadBgColor=#eeeeee Width=30  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} EditStyle=Combo Data='I:신규,U:수정,C:취소' suppress=2</FC> 				         "  
												+ "</FG>                                                                                                                                                                                                                                     "  											
												+ " <C> Name='배정번호'		ID=CAR_SEQ_NO  	 HeadAlign=Center	HeadBgColor=#eeeeee Width=60  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C>"
												+ " <C> Name='배차번호'		ID=BAECHA_NO  	 HeadAlign=Center	HeadBgColor=#eeeeee Width=60  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C>"
												+ " <C> Name='차종'			  ID=CAR_TYPE_NM   HeadAlign=Center	HeadBgColor=#eeeeee Width=80  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C>"
												+ " <C> Name='기사명'			ID=PERSON_NO  	 HeadAlign=Center	HeadBgColor=#eeeeee Width=45  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C>"
												+ " <C> Name='차량번호'		ID=CAR_NO  	     HeadAlign=Center	HeadBgColor=#eeeeee Width=80  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C>"
												+ " <C> Name='대표물품'		ID=RDS_GOODS  	 HeadAlign=Center	HeadBgColor=#eeeeee Width=90  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C>"
												+ " <C> Name='상차지'			ID=LD_CARGO_NM	 HeadAlign=Center	HeadBgColor=#eeeeee Width=80  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C>"
												+ " <C> Name='하차지'			ID=OFF_CARGO_NM	 HeadAlign=Center	HeadBgColor=#eeeeee Width=80  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C>"
												+ " <G> Name='출발'  HeadAlign=Center HeadBgColor=#eeeeee                                                                                                                                                                                 "
												+ " <C> Name='일자'		ID=START_DATE  	 HeadAlign=Center	HeadBgColor=#eeeeee Width=68 align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} MASK='XXXX/XX/XX'</C>"
												+ " <C> Name='시간'		ID=START_TIME  	 HeadAlign=Center	HeadBgColor=#eeeeee Width=38 align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} MASK='XX:XX'</C>"
												+ "</G>                                                                                                                                                                                                                                     "  
												+ " <G> Name='복귀'  HeadAlign=Center HeadBgColor=#eeeeee                                                                                                                                                                                 "
												+ " <C> Name='일자'		ID=RTRN_DATE  	 HeadAlign=Center	HeadBgColor=#eeeeee Width=68 align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} MASK='XXXX/XX/XX'</C>"
												+ " <C> Name='시간'		ID=RTRN_TIME  	 HeadAlign=Center	HeadBgColor=#eeeeee Width=38 align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} MASK='XX:XX'</C>"
												+ "</G>                                                                                                                                                                                                                                     "  

		 }else if(gclx_gubun.bindcolval==3){ //입고
				gcgd_data.Format= "<FC> Name='No.'	      ID=''            HeadAlign=Center HeadBgColor=#eeeeee Width=25  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} Value={ToString(RowCount-CurRow+1)}</FC>                                      "
												+ "<FC> Name='선택'	      ID=CHK  		     HeadAlign=Center	HeadBgColor=#eeeeee Width=25  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} Editstyle='checkbox' cursor=hand</FC>                                         "
												+ "<FG> Name='EDI공용DB'  HeadAlign=Center HeadBgColor=#eeeeee                                                                                                                                                                                "
												+ "	<FC> Name='전송수신'  ID=HL_EDI_STS	   HeadAlign=Center	HeadBgColor=#eeeeee Width=62  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} EditStyle=Combo Data='N:미수신,S:수신중,Y:수신완료,A:재수신' suppress=1</FC>  "
												+ "	<FC> Name='상태'	    ID=HL_ING_STS	   HeadAlign=Center	HeadBgColor=#eeeeee Width=30  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} EditStyle=Combo Data='I:신규,U:수정,C:취소' suppress=2</FC> 				          "
												+ "</FG>                                                                                                                                                                                                                                      "
												+ "  <C> Name='실화주'	  ID=SHIPPERNM  	 HeadAlign=Center	HeadBgColor=#eeeeee Width=99  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ "  <C> Name='입고일자'	ID=ENTER_DATE  	 HeadAlign=Center	HeadBgColor=#eeeeee Width=68  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} MASK='XXXX/XX/XX'"
												+ "  <C> Name='입고번호'	ID=ENTER_NO  	   HeadAlign=Center	HeadBgColor=#eeeeee Width=55  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ "  <C> Name='SEQ'   		ID=GOODS_SEQ  	 HeadAlign=Center	HeadBgColor=#eeeeee Width=25  align=right   bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ "  <C> Name='물류센터'	ID=WRHSNM        HeadAlign=Center	HeadBgColor=#eeeeee Width=80  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ "  <C> Name='물품명'		ID=ARTC_NM  	   HeadAlign=Center	HeadBgColor=#eeeeee Width=80  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
           							+ "  <C> Name='수량'		  ID=ARTC_CNT  	   HeadAlign=Center	HeadBgColor=#eeeeee Width=50  align=right   bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ "<G> Name='단위포장'  HeadAlign=Center   HeadBgColor=#eeeeee                                                                                                                                                                                "
												+ "  <C> Name='길이'			ID=PKG_LNGTH		 HeadAlign=Center	HeadBgColor=#eeeeee Width=50  align=right    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ "  <C> Name='폭'			  ID=PKG_WIDTH		 HeadAlign=Center	HeadBgColor=#eeeeee Width=50  align=right    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ "  <C> Name='높이'			ID=PKG_HEIGHT		 HeadAlign=Center	HeadBgColor=#eeeeee Width=50  align=right    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ "  <C> Name='용적'			ID=PKG_CBM  		 HeadAlign=Center	HeadBgColor=#eeeeee Width=50  align=right    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ "  <C> Name='중량'			ID=PUNIT_WEIGHT  HeadAlign=Center	HeadBgColor=#eeeeee Width=50  align=right    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ "  <C> Name='포장수량'	ID=PKG_CNT			 HeadAlign=Center	HeadBgColor=#eeeeee Width=50  align=right    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ "</G>                                                                                                                                                                                                                                      "
												+ " <C> Name='총용적'   	ID=TOTAL_CBM  	 HeadAlign=Center	HeadBgColor=#eeeeee Width=50  align=right    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ " <C> Name='총수량'   	ID=TOTAL_WEIGHT  HeadAlign=Center	HeadBgColor=#eeeeee Width=50  align=right    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "      

		 }else if(gclx_gubun.bindcolval==4){ //상차
				gcgd_data.Format= "<FC> Name='No.'	      ID=''            HeadAlign=Center HeadBgColor=#eeeeee Width=25  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} Value={ToString(RowCount-CurRow+1)}</FC>                                      "
												+ "<FC> Name='선택'	      ID=CHK  		     HeadAlign=Center	HeadBgColor=#eeeeee Width=25  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} Editstyle='checkbox' cursor=hand</FC>                                         "
												+ "<FG> Name='EDI공용DB'  HeadAlign=Center HeadBgColor=#eeeeee                                                                                                                                                                                "
												+ "	<FC> Name='전송수신'  ID=HL_EDI_STS	   HeadAlign=Center	HeadBgColor=#eeeeee Width=62  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} EditStyle=Combo Data='N:미수신,S:수신중,Y:수신완료,A:재수신' suppress=1</FC>  "
												+ "	<FC> Name='상태'	    ID=HL_ING_STS	   HeadAlign=Center	HeadBgColor=#eeeeee Width=30  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} EditStyle=Combo Data='I:신규,U:수정,C:취소' suppress=2</FC> 				          "
												+ "</FG>                                                                                                                                                                                                                                      "
												+ "  <C> Name='주문번호'	ID=ORDER_NO   	 HeadAlign=Center	HeadBgColor=#eeeeee Width=65  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ "  <C> Name='SEQ'	      ID=ORDER_SEQ  	 HeadAlign=Center	HeadBgColor=#eeeeee Width=30  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ "  <C> Name='물품명'	  ID=ARTC_NM  	   HeadAlign=Center	HeadBgColor=#eeeeee Width=70  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ "  <C> Name='배정번호'	ID=CAR_SEQ_NO	   HeadAlign=Center	HeadBgColor=#eeeeee Width=60  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
           							+ "  <C> Name='수량'		  ID=ARTC_CNT  	   HeadAlign=Center	HeadBgColor=#eeeeee Width=45  align=right   bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ "<G> Name='단위포장'  HeadAlign=Center   HeadBgColor=#eeeeee                                                                                                                                                                                "
												+ "  <C> Name='길이'			ID=PKG_LNGTH		 HeadAlign=Center	HeadBgColor=#eeeeee Width=50  align=right    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ "  <C> Name='폭'			  ID=PKG_WIDTH		 HeadAlign=Center	HeadBgColor=#eeeeee Width=50  align=right    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ "  <C> Name='높이'			ID=PKG_HEIGHT		 HeadAlign=Center	HeadBgColor=#eeeeee Width=50  align=right    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ "  <C> Name='중량'			ID=PUNIT_WEIGHT  HeadAlign=Center	HeadBgColor=#eeeeee Width=50  align=right    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ "  <C> Name='포장수량'	ID=PKG_CNT			 HeadAlign=Center	HeadBgColor=#eeeeee Width=50  align=right    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ "</G>                                                                                                                                                                                                                                      "
												+ " <C> Name='총용적'   	ID=TOTAL_CBM  	 HeadAlign=Center	HeadBgColor=#eeeeee Width=50  align=right    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "
												+ " <C> Name='총수량'   	ID=TOTAL_WEIGHT  HeadAlign=Center	HeadBgColor=#eeeeee Width=50  align=right    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} "      
		 }
	}

	/******************************************************************************
		Description :  ADD COMBO == "선택" 
	******************************************************************************/
	function AddChoice(obj){
		obj.InsertRow(1) ; 
		obj.NameValue(1,"MINORCD" )  = "" ; 
		obj.NameValue(1,"MINORNM" )  = "====선택====" ;  
	}

	/******************************************************************************
		Description : EDI 수신
	******************************************************************************/
	function ln_Trans_Recevie(){

	  if(!ln_Chk_EDI()) return;

		if(gclx_gubun.bindcolval==1){ //주문배정
		  if (confirm(" 주문배정정보를 수신하시겠습니까?")){
				gcTr01.KeyValue = "tr00104_edi_t1_r(I:USER=gcDs1)";
				gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00104_edi_t1_r";
				gcTr01.Parameters = "gstr1="+gusrid; //사용자

				gcTr01.post(); 
			} 
    }else if(gclx_gubun.bindcolval==2){ //배차
		  if (confirm(" 배차정보를 수신하시겠습니까?")){
				gcTr01.KeyValue = "tr00104_edi_t3_r(I:USER=gcDs1)";
				gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00104_edi_t3_r";
				gcTr01.Parameters = "gstr1="+gusrid; //사용자

				gcTr01.post(); 
      }
		}else if(gclx_gubun.bindcolval==3){ //입고
		  if (confirm(" 입고정보를 수신하시겠습니까?")){
		    gcTr01.KeyValue = "tr00104_edi_t4_r(I:USER=gcDs1)";
				gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00104_edi_t4_r";
				gcTr01.Parameters = "gstr1="+gusrid; //사용자

				gcTr01.post(); 
      }
		}else if(gclx_gubun.bindcolval==4){ //상차
			 if (confirm(" 상차정보를 수신하시겠습니까?")){
		    gcTr01.KeyValue = "tr00104_edi_t5_r(I:USER=gcDs1)";
				gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00104_edi_t5_r";
				gcTr01.Parameters = "gstr1="+gusrid; //사용자

				gcTr01.post(); 
      }
    }

	}

	
	/******************************************************************************
		Description : EDI 수신
	******************************************************************************/
	function ln_Chk_EDI(){
	  var chk=0;
		_out:
	  for(i=1;i<=gcDs1.countrow;i++){
			if(gcDs1.namevalue(i,"CHK")==1){
				chk="T";
				break _out;
			}
		}
	
		if(chk==0){
			alert("전송할 대상이 없습니다.");
			return false;
  	}
		return true;
	}

	/******************************************************************************
		Description : EDI 수신
	******************************************************************************/
	function ln_Enable(){
		if(gcrd_sendgb.codevalue==1){ //일괄수신
			gclx_in_out.index=0;
			gclx_ing_sts.index=0;
			gclx_edi_sts.index=1; //미수신

			gclx_in_out.enable=false;
			gclx_ing_sts.enable=false;
			gclx_edi_sts.enable=false;
		}else{
			gclx_in_out.enable=true;
			gclx_ing_sts.enable=true;
			gclx_edi_sts.enable=true;
		}
	}

</SCRIPT> 


<!-----------------------------------------------------------------------------
		G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcDs1" event="OnLoadStarted()">
	OnStatusStart(); 
</script>

<script language="javascript" for="gcDs1" event="onLoadCompleted(row,colid)">
	TheStatusEnd(row); 
</script>

<script language=JavaScript for=gcDs1 event=OnLoadError()>

  alert("onLoadError:::ErrorCode:::"+gcDs1.ErrorCode+"::ErrorMsg::"+gcDs1.ErrorMsg);

</script>

<script language=JavaScript for=gcgd_data event=OnClick(row,colid)>
	if (row<1) {
		if(row==0&&colid=="CHK"){
		  if(gcDs1.namevalue(1,colid)==0){
				for(i=1;i<=gcDs1.countrow;i++){
					gcDs1.namevalue(i,colid) = 1;
				}
      }else{
				for(i=1;i<=gcDs1.countrow;i++){
					gcDs1.namevalue(i,colid) = 0;
				}
			}
		}
	}else{
		if (colid=="CHK"){
			if (gcDs1.namevalue(row,colid) == 1) gcDs1.namevalue(row,colid) = 0;
			else gcDs1.namevalue(row,colid) = 1;

			 for(i =1 ; i<=gcDs1.CountRow ; i++ ) {
				if(gcDs1.NameValue(row,"ORDER_NO") == gcDs1.NameValue(i,"ORDER_NO" )){
					gcDs1.NameValue(i,"CHK" ) = gcDs1.NameValue(row,"CHK") ; 
				} 
			}
		}
	}
</script>

<script language=JavaScript for="gcDs2" event=OnLoadCompleted(rowcnt)> 
	AddChoice(gcDs2) ; 
	gclx_line_part.Index = 0 ; 
</script>


<script language=JavaScript for="gcDs4" event=OnLoadCompleted(rowcnt)> 
	AddChoice(gcDs4) ; 
</script>


<script language=JavaScript for=gcrd_sendgb event=OnSelChange()>
	ln_Enable();
</script>

<!-----------------------------------------------------------------------------
		G A U C E   C O M P O N E N T' S
		Tranaction    E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcTr01 event=OnSuccess()>
  if(gclx_gubun.bindcolval==1){	 //주문배정
		alert("주문배정 수신을 완료하였습니다.");
	}else if(gclx_gubun.bindcolval==2){	 //배차
    alert("배차 수신을 완료하였습니다.");
  }else if(gclx_gubun.bindcolval==3){	 //입고
    alert("입고 수신을 완료하였습니다.");
	}else if(gclx_gubun.bindcolval==4){	 //상차
    alert("상차 수신을 완료하였습니다.");
	}
</script>

<script language=JavaScript for=gcTr01 event=OnFail()>
  alert("Error Code : " + gcTr01.ErrorCode + "\n" + "Error Message : " + gcTr01.ErrorMsg + "\n");
</script>
</HEAD>

<BODY onLoad="ln_Start()">
	<table width="830" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:5px;">
		<tr> 
			<td width="830" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">  
				<img src="../../../Common/img/btn/com_b_trans_re.gif" style="cursor:hand" onclick="ln_Trans_Recevie()">
				<img src="../../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
			</td>
		</tr>
		<tr><td height=5px></td></tr>
		<tr>
			<td colspan=2>
				<table border=0 cellpadding=0 cellspacing=0 style="border:1 solid #708090;border-bottom-width:0px;border-right-width:0px;width:100%">
					<tr>
						
						<td class="tab11" style="width:80px;" bgcolor="#efefef">수신구분</td>
						<td class="tab21">
								<%=HDConstant.COMMENT_START%>
								<object id=gcrd_sendgb classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0	style="height:24; width:140">
								<param name=Cols	  value="2">
			          			<param name=Format	value="1^일괄수신,2^부분수신">
								<param name=Enable 	value="true">
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						
						<td class="tab11" style="width:80px;height:30px;" bgcolor="#efefef">프로젝트</td>
						<td class="tab21" style="width:120px;">
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_line_part  style='position:relative;left:8px;top:1px;width:100px;height:180' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  tabindex="1">
								<param name=ComboDataID			value="gcDs2">  
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value="MINORNM">
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value="True">
								<param name=ListExprFormat	value="MINORNM^0^158">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value="0">
								<param name=InheritColor		value="true"> 
							</OBJECT><%=HDConstant.COMMENT_END%> 
						</td>

						<td class="tab11" style="width:80px;" bgcolor="#efefef">반출일자</td>
						<td class="tab21">
							<%=HDConstant.COMMENT_START%><OBJECT id=gcem_edt_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:6px; width:70px; height:17px; font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
							</OBJECT><%=HDConstant.COMMENT_END%>
							<img src="../../../Common/img/btn_calendar.gif" style="position:relative; left:8px;top:2px;cursor:hand" onclick="__GetCallCalendar('gcem_edt_dt', 'Text');">&nbsp;&nbsp;&nbsp;
						</td>

						<td class="tab11" style="width:80px;" bgcolor="#efefef">EDI구분</td>
						<td class="tab21">
								<%=HDConstant.COMMENT_START%><OBJECT id=gclx_gubun  style='position:relative;left:8px;top:1px;width:100px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  tabindex="1">
								<param name=CBData					value="1^주문배정,2^배차,3^입고,4^상차">
								<param name=CBDataColumns		value="code,name">
								<param name=SearchColumn		value=name>
								<param name=Sort						value=false>
								<param name=Enable          value="false">
								<param name=ListExprFormat	value="name^0^100">								
								<param name=BindColumn			value="code">								
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td>

					</tr>
					<tr>
						<td class="tab11" style="width:80px;height:30px;" bgcolor="#efefef">반출입구분</td>
						<td class="tab21" style="width:120px;">
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_in_out style='position:relative;left:8px;top:1px;width:100px;height:180' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  tabindex="1">
								<param name=ComboDataID			value="gcDs4">  
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value="MINORNM">
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value="True">
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value="0">
								<param name=InheritColor		value="true"> 
							</OBJECT><%=HDConstant.COMMENT_END%> 
						</td>

						<td class="tab11" style="width:80px;" bgcolor="#efefef">상태구분</td>
						<td class="tab21" style="width:120px;" >
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_ing_sts  style='position:relative;left:8px;top:1px;width:100px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  tabindex="1">
								<param name=CBData					value="''^전체,I^신규,U^수정,C^취소">
								<param name=CBDataColumns		value="code,name">
								<param name=SearchColumn		value=name>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="name^0^100">								
								<param name=BindColumn			value="code">								
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td>

						<td class="tab11" style="width:80px;" bgcolor="#efefef">수신여부</td>
						<td class="tab21" style="width:120px;" colspan=3>
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_edi_sts  style='position:relative;left:8px;top:1px;width:100px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  tabindex="1">
								<param name=CBData					value="''^전체,S^수신중,Y^수신완료,A^재수신">
								<param name=CBDataColumns		value="code,name">
								<param name=SearchColumn		value=name>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="name^0^50">								
								<param name=BindColumn			value="code">											
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height=5px></td></tr>
		<tr>
			<td colspan=2> 
				<table  cellpadding="0" cellspacing="0" border="0" style="width:300px;height:30px;font-size:9pt;background-color:#ffffff;border:0 solid #708090">
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data style="width:830;height:321px;border:1 solid #777777;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"		VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="false">
								<param name="AllShowEdit" VALUE="true">
								<Param Name="LineColor"   value="Green">
								<param name="ColSizing"   value="true">
								<param name="ViewSummary" VALUE="true">
								<param name="DragDropEnable" value="true">
								<PARAM NAME="IndWidth"		VALUE ='0'>
								<PARAM NAME="Format"			VALUE="  
									<FC> Name='No.'	        ID=GRAYY         HeadAlign=Center HeadBgColor=#eeeeee Width=28  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} Value={ToString(RowCount-CurRow+1)}</FC> 
									<FC> Name='선택'			  ID=CHK  			   HeadAlign=Center	HeadBgColor=#eeeeee Width=28  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} Editstyle='checkbox' cursor=hand</FC> 
									<FC> Name='구분'	      ID=INGGB   		   HeadAlign=Center	HeadBgColor=#eeeeee Width=58  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} suppress=1</FC>
									<FG> Name='EDI공용DB'   HeadAlign=Center	HeadBgColor=#eeeeee
										<FC> Name='전송수신'  ID=HL_EDI_STS	   HeadAlign=Center	HeadBgColor=#eeeeee Width=62  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} EditStyle=Combo Data='N:미수신,S:수신중,Y:수신완료,A:재수신' suppress=2</FC> 				
										<FC> Name='상태'	    ID=HL_ING_STS	   HeadAlign=Center	HeadBgColor=#eeeeee Width=30  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} EditStyle=Combo Data='I:신규,U:수정,C:취소' suppress=3</FC> 				
									</FG> 
									<FC> Name='반출일자'	  ID=ETD_DT		     HeadAlign=Center	HeadBgColor=#eeeeee Width=68  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} MASK='XXXX-XX-XX' , suppress=4</FC> 
									<FC> Name='주문번호'	  ID=ORDER_NO		   HeadAlign=Center	HeadBgColor=#eeeeee Width=68  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} suppress=5</FC> 
									<FC> Name='배정번호'	  ID=CAR_SEQ_NO	   HeadAlign=Center	HeadBgColor=#eeeeee Width=68  align=center  bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} suppress=6</FC> 
									<FC> Name='차량종류'	  ID=CARGO_TYPE	   HeadAlign=Center	HeadBgColor=#eeeeee Width=100 align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} suppress=7  EditStyle=Lookup	Data='gcDs3:MINORCD:MINORNM' show=false</FC> 
									<FC> Name='화주'			  ID=SHIPPERNM     HeadAlign=Center	HeadBgColor=#eeeeee Width=110 align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} suppress=8</FC> 
									<C> Name='품명'			    ID=ARTC_NM  	   HeadAlign=Center	HeadBgColor=#eeeeee Width=110 align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C> 
									<C> Name='상차지'		    ID=LD_CARGO_NM   HeadAlign=Center	HeadBgColor=#eeeeee Width=70  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C> 
									<C> Name='상차지상세'	  ID=LD_CARGONM	   HeadAlign=Center	HeadBgColor=#eeeeee Width=120 align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C> 
									<C> Name='하차지'			  ID=OFF_CARGO_NM	 HeadAlign=Center	HeadBgColor=#eeeeee Width=70  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C> 
									<C> Name='하차지상세'	  ID=OFF_CARGONM   HeadAlign=Center	HeadBgColor=#eeeeee Width=120 align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C> 
									<C> Name='송하인TEL'	  ID=SHIPPERTEL	   HeadAlign=Center	HeadBgColor=#eeeeee Width=90  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C> 
									<C> Name='송하인HP'	    ID=SHIPPERHP	   HeadAlign=Center	HeadBgColor=#eeeeee Width=90  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C> 
									<C> Name='수하인TEL'	  ID=RECP_TEL  	   HeadAlign=Center	HeadBgColor=#eeeeee Width=90  align=left    bgcolor={IF(HL_EDI_STS='S' OR HL_EDI_STS='A','Yellow')} </C> 
								">
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
					</tr> 

					<tr>
						<td> <br>
							* 일괄수신은 미수신 데이터를 기준으로 수신합니다.<br>
							* 부분수신은 검색 조건에 따른 데이터를 수신합니다.<br>
							* 공용DB의 내용을 검색한 내용입니다.
						</td>
					</tr>
				</table> 

			</td>
		</tr>
	</table>
	<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->

</BODY>
</HTML>
