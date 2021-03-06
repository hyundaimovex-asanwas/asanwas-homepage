<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산 반입주문조회
+ 프로그램 ID	: TR00201.HTML
+ 기 능 정 의	: 반입주문조회
+ 변 경 이 력	: 정미선
+ 작성일자 :
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


<!-- /******************************************************************************
	Description : DataSet 선언
******************************************************************************/ --> 
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcDs1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT>

<OBJECT id=gcDs2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"> 
</OBJECT>

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT>

<OBJECT id=gcDs_etc2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT>

<OBJECT id=gcDs_etc3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT>

<OBJECT id=gcDs_etc33 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT>

<OBJECT id=gcDs_etc4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"> 
</OBJECT>

<OBJECT id=gcDs_etc5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT>

<OBJECT id=gcDs_etc6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT>

<OBJECT id=gcDsgetdate classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT>

<OBJECT id=gcDsrpt1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false">
</OBJECT>

<OBJECT id=gcDs_etc11 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad		value="true">
	 <param name=UseFilter	value="true">
</OBJECT>

<OBJECT id=gcds_report01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT>

<OBJECT id=gcds_report02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad		value="true">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id="gcTr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--주문 마스터-->
</OBJECT>
<%=HDConstant.COMMENT_END%>

<SCRIPT language=JavaScript>
	get_cookdata();
	
	var	lb_boolean1 =  false ; 
	var format_type = 'A';
    var gs_date = '<%=firstday%>';
	var gs_date1 = gs_date.substring(0,6) + "01";

	/*----------------------------------------------------------------------------
	 * 페이지로딩
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]

			Start();//선조회

			window.status="완료";

		}
	/******************************************************************************
		Description : 페이지 로딩
	******************************************************************************/ 
	function Start(){

		tb_detail.style.display = 'none' ; 
		
		gcDs_etc11.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsProject_s01?v_str1="; //물류비 부담
		gcDs_etc11.Reset();
		
		gcDs_etc1.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0002"; //Project
		gcDs_etc1.Reset();
		
		gcDs_etc2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0003"; //적재구분
		gcDs_etc2.Reset();
		
		gcDs_etc3.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s4"; //상태
		gcDs_etc3.Reset();
		
		gcDs_etc33.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0001"; //납품구분
		gcDs_etc33.Reset();
		
		gcDs_etc4.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e4?NOH=Y";  //차종
		gcDs_etc4.Reset(); 
		
		gcDs_etc5.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007"; //상차지
		gcDs_etc5.Reset();
		
		gcDs_etc6.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007"; //하차지
		gcDs_etc6.Reset();

		SEARCH_TYPE.index = 0 ; 
		
		FROM_DATE.Text = gs_date ;

		gcDsgetdate.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsGetDates?NOH=Y&gstr1=0001";  //Project 
			
		gcDsgetdate.Reset() ;
		
		if(gcDsgetdate.CountRow > 0 ) TO_DATE.Text =  gcDsgetdate.NameValue(1,"APP_DT1");

	}

	/******************************************************************************
		Description : 조회
	******************************************************************************/ 
	function ln_Query(){
	
		var parm = "&gstr0=I"
						 + "&gstr1=" + SEARCH_TYPE.BindColVal
						 + "&gstr2=" + FROM_DATE.Text
						 + "&gstr3=" + TO_DATE.Text
						 + "&gstr4=" + LINE_PART.BindColVal
						 + "&gstr5=" + PROJECT.BindColVal
						 + "&gstr6=" + ORDER_NO.Text
						 + "&gstr7=" + CUST_CDNM.value
						 + "&gstr8=" + CARGO_TYPE.BindColVal
						 + "&gstr9=" + DLVL_TYPE.BindColVal
						 + "&gstr10=" + SHIPPER_NM.value;


		gcDs1.DataId =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsOrderList5?NOH=Y"+parm ; 
		gcDs1.Reset() ; 
	}


  /******************************************************************************
		Description :	삭제
                  2008.11.05 jys 삭제시 체크 부분 추가 
	******************************************************************************/ 
	function ln_Delete(){
	
    var strSendGb="";     //전송구분
    var strChkGb="";      //체크박스 구분

		gcDs1.ClearAllMark();
		if (gcDs1.countrow<1) return;

		if (gcDs1.namevalue(gcDs1.rowposition,"ORDER_STS")!="0001"){
      for(i=1;i<=gcDs1.CountRow;i++){
				if(gcDs1.namevalue(i,"RATE_FLAG")=="1"){
           strChkGb="Y"
					 if(gcDs1.namevalue(i,"EDI_STS")=="S"||gcDs1.namevalue(i,"EDI_STS")=="A"||gcDs1.namevalue(i,"EDI_STS")=="Y"){
							alert("EDI 전송이 되었습니다. 삭제 할 수 없습니다.");
              return false;
           }else{
							strSendGb="Y";
           }
        }
      } 

      if(strChkGb!="Y"){
				alert("삭제할 데이터를 선택하십시요.");
        return false;
      }

      if(strSendGb=="Y"){
				alert("접수된 주문정보이오니 한번더 확인해 주십시오.");
      }
		}
  

		if (confirm("선택하신 주문정보를 삭제하시겠습니까 ?  ")){
			for(i=1;i<=gcDs1.CountRow;i++) {

				if(gcDs1.namevalue(i,"RATE_FLAG")=="1") { //체크
					gcDs1.RowMark(i)=1;			
				}
			}	
	
			gcDs1.DeleteMarked();
			gcTr1.KeyValue = "trOrderCar(I:DATA=gcDs1)";
			gcTr1.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_t1";

			gcTr1.post();
		}


	}



	/******************************************************************************
		Description : 그리드 포멧 변경
	******************************************************************************/ 
	function Chang_Format(){
		if(format_type != SEARCH_TYPE){ 
			if(SEARCH_TYPE.BindColVal =="A"){
				gcGR1.Format  = "<F> Name=''					 ID=RATE_FLAG 	HeadAlign=Center HeadBgColor=#E8E8E8 Width=20	 align=center editstyle=checkbox, HeadCheck=false HeadCheckShow=true, cursor=hand</F> "
											+ "<F> Name='No.'				 ID='SeralNo' 	HeadAlign=Center HeadBgColor=#E8E8E8 Width=30	 align=center bgcolor='#EFEFEF' Value={ToString(RowCount-CurRow+1)}	</F> "
											+ "<C> Name='주문번호'   ID=ORDER_NO		HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center</C> "
											+ "<C> Name='상태'       ID=ORDER_STS		HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center , editstyle=LookUp Data='gcDs_etc3:MINORCD:MINORNM' </C> "
											+ "<C> Name='반입일자'   ID=ETD_DT			HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center MASK ='XXXX-XX-XX'</C> "
											+ "<C> Name='Project명'  ID=LINE_PART		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left EditStyle=Lookup Data='gcDs_etc1:MINORCD:MINORNM'</C> "
											+ "<C> Name='물류비 부담'   ID=CDNAM				HeadAlign=Center HeadBgColor=#eeeeee Width=150  align=left</C> "
											+ "<C> Name='신청업체명' ID=CUST_NM			HeadAlign=Center HeadBgColor=#eeeeee Width=163  align=left</C> "
											+ "<C> Name='담당자'     ID=CUST_PRSN  	HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=left </C> "
											+ "<C> Name='화주'       ID=SHIPPER_NM	HeadAlign=Center HeadBgColor=#eeeeee Width=170  align=left</C> "
											+ "<C> Name='담당자'     ID=SHIPPERPS  	HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=left</C> "
											+ "<C> Name='적재구분'  ID=CARGO_TYPE  	HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=left , editstyle=LookUp Data='gcDs_etc2:MINORCD:MINORNM'</C> "
											+ "<C> Name='제출일자'   ID=CREATE_DT		HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center </C> "
		                  + "<C> Name='전송상태'   ID=EDI_STS		  HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=left EditStyle=Combo Data='1:미전송,S:전송중,T:전송완료' </C> "
											+ "<C> Name='수정상태'   ID=ING_STS		  HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=left EditStyle=Combo Data='X:삭제,M:수정,C:취소' </C> "
			} else if(SEARCH_TYPE.BindColVal =="B") {
				gcGR1.Format  = "<F> Name=''					 ID=RATE_FLAG 	HeadAlign=Center HeadBgColor=#E8E8E8 Width=20	 align=center editstyle=checkbox, HeadCheck=false HeadCheckShow=true, cursor=hand</F> "
											+ "<F> Name='No.'				 ID='SeralNo'   HeadAlign=Center HeadBgColor=#E8E8E8 Width=30	 align=center Bgcolor='#EFEFEF' Value={ToString(RowCount-CurRow+1)}	</F> "
											+ "<C> Name='주문번호'   ID=ORDER_NO		HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center suppress=1</C>	"
											+ "<C> Name='상태'       ID=ORDER_STS		HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center , editstyle=LookUp Data='gcDs_etc3:MINORCD:MINORNM' suppress=1</C> "
											+ "<C> Name='반입일자'   ID=ETD_DT			HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center MASK ='XXXX-XX-XX' suppress=1</C> "
											+ "<C> Name='Project명'  ID=LINE_PART		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left EditStyle=Lookup Data='gcDs_etc1:MINORCD:MINORNM' suppress=1</C> "
											+ "<C> Name='차량종류'   ID=CARTYPENO		HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=left EditStyle=Lookup Data='gcDs_etc4:CAR_TYPE:CAR_NAME'</C> "
											+ "<C> Name='배정번호'   ID=CAR_SEQ_NO	HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center</C> "
											+ "<C> Name='물류비 부담'   ID=CDNAM				HeadAlign=Center HeadBgColor=#eeeeee Width=140  align=left</C> "
											+ "<C> Name='신청업체명' ID=CUST_NM			HeadAlign=Center HeadBgColor=#eeeeee Width=173  align=left</C> "
											+ "<C> Name='담당자'     ID=CUST_PRSN  	HeadAlign=Center HeadBgColor=#eeeeee Width=75  align=left </C> "
											+ "<C> Name='화주'       ID=SHIPPER_NM  HeadAlign=Center HeadBgColor=#eeeeee Width=180  align=left</C> "
											+ "<C> Name='담당자'     ID=SHIPPERPS  	HeadAlign=Center HeadBgColor=#eeeeee Width=75  align=left</C> "
											+ "<C> Name='적재구분'	 ID=CARGO_TYPE  HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=left , editstyle=LookUp Data='gcDs_etc2:MINORCD:MINORNM'</C> "
											+ "<C> Name='제출일자'   ID=CREATE_DT		HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center </C> "
			                + "<C> Name='전송상태'   ID=EDI_STS		  HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=left EditStyle=Combo Data='1:미전송,S:전송중,T:전송완료' </C> "
											+ "<C> Name='수정상태'   ID=ING_STS		  HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=left EditStyle=Combo Data='X:삭제,M:수정,C:취소' </C> "
			} else 	if(SEARCH_TYPE.BindColVal =="C") {
				gcGR1.Format  = "<F> Name=''							ID=RATE_FLAG 	HeadAlign=Center HeadBgColor=#E8E8E8 Width=20	 align=center editstyle=checkbox, HeadCheck=false HeadCheckShow=true, cursor=hand</F> "
											+ "<F> Name='No.'						ID='SeralNo'  HeadAlign=Center HeadBgColor=#E8E8E8 Width=30	 align=center Bgcolor='#EFEFEF' Value={ToString(RowCount-CurRow+1)}	</F> "
											+ "<C> Name='주문번호'      ID=ORDER_NO   HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center edit = none  suppress=1</C> "
											+ "<C> Name='주문번호;상세' ID=ORDER_SEQ  HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=center  </C> "
											+ "<C> Name='주문상태'      ID=ORDER_STS  HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center editstyle=LookUp Data='gcDs_etc3:MINORCD:MINORNM' </C>  "
											+ "<C> Name='반입일자'			ID=ETD_DT     HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=center  Mask='XXXX-XX-XX' </C> "
											+ "<C> Name='프로젝트구분'  ID=LINE_PART  HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left , editstyle=LookUp Data='gcDs_etc1:MINORCD:MINORNM' </C> "
											+ "<C> Name='상차지'        ID=LDCARGO    HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center , editstyle=LookUp Data='gcDs_etc5:MINORCD:MINORNM' </C> "
											+ "<C> Name='하차지'        ID=OFFCARGO   HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center , editstyle=LookUp Data='gcDs_etc6:MINORCD:MINORNM' </C> "
											+ "<C> Name='물류비 부담'      ID=CDNAM			HeadAlign=Center HeadBgColor=#eeeeee Width=140  align=left EditStyle=Lookup Data='gcDs_etc1:MINORCD:MINORNM' suppress=1</C> "
											+ "<C> Name='업체명'        ID=CUST_NM    HeadAlign=Center HeadBgColor=#eeeeee Width=140  align=left  </C>"
											+ "<C> Name='구분'					ID=CARGO_TYPE HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center , editstyle=LookUp Data='gcDs_etc2:MINORCD:MINORNM'</C> "
											+ "<C> Name='납품구분'      ID=DLVL_TYPE  HeadAlign=Center HeadBgColor=#eeeeee Width=120  align=left , editstyle=LookUp Data='gcDs_etc33:MINORCD:MINORNM' </C>"
											+ "<C> Name='품명'					ID=ARTC_NM    HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=left </C> "
											+ "<C> Name='규격'					ID=STN_SZNM   HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=left  </C> <C> Name='수량' ID=ARTC_CNT HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=right  </C> "
											+ "<C> Name='단위'					ID=ARTC_UNIT  HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=left  </C> "
											+ "<C> Name='단가'					ID=UNIT_PRICE HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right   </C> "
											+ "<C> Name='금액'					ID=PRICE HeadAlign=Center HeadBgColor=#eeeeee Width=110  align=right  </C>"
											+ "<G> Name='단위포장'  HeadBgColor=#eeeeee "
											+ "  <C> Name='수량'					ID=PUNIT_CNT  HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=right  </C> "
											+ "  <C> Name='수량단위'			ID=PUNIT_UNIT   HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=center </C>"
											+ "  <C> Name='포장중량(KG)'  ID=PUNIT_WGHT   HeadAlign=Center HeadBgColor=#eeeeee Width=110  align=right  </C>"
											+ "</G>"
											+ "<G> Name='포장크기'  HeadBgColor=#eeeeee "
											+ "  <C> Name='길이(CM)'	ID=PKG_LNGTH   HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=right  </C> 	"
											+ "  <C> Name='폭(CM)'		ID=PKG_WIDTH   HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=right   </C> 	"
											+ "  <C> Name='높이(CM)'	ID=PKG_HEIGHT  HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=right   </C> 	"
											+ "  <C> Name='용적(CBM)' ID=PKG_CBM     HeadAlign=Center HeadBgColor=#eeeeee Width=93  align=right  </C> 	"
											+ "  <C> Name='수량'			ID=PKG_CNT     HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=right   </C> 	"
											+ "</G>"
											+ "<C> Name='상차지상세정보'	ID=LDCARGONM   HeadAlign=Center HeadBgColor=#eeeeee Width=170  align=left  </C>"
											+ "<C> Name='하차지상세정보'	ID=OFFCARGONM  HeadAlign=Center HeadBgColor=#eeeeee Width=170  align=left  </C> "
											+ "<C> Name='제출일자'   ID=CREATE_DT		HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center </C> "
		                  + "<C> Name='전송상태'   ID=EDI_STS		  HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=left EditStyle=Combo Data='1:미전송,S:전송중,T:전송완료' </C> "
											+ "<C> Name='수정상태'   ID=ING_STS		  HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=left EditStyle=Combo Data='X:삭제,M:수정,C:취소' </C> "
			}

			format_type = SEARCH_TYPE.BindColVal ; 
		}
	}

	/******************************************************************************
		Description :  ADD COMBO == "선택" 
	******************************************************************************/
	function AddChoice(obj){
		obj.InsertRow(1) ; 
		obj.NameValue(1,"MINORCD" )  = "" ; 
		obj.NameValue(1,"MINORNM" )  = "=선택 or 입력=" ;  
	}

	/******************************************************************************
		Description :  ADD COMBO == "선택" 
	******************************************************************************/
	function AddChoiceProjct(obj){
		obj.InsertRow(1) ; 
		obj.NameValue(1,"TR_PROJECT" )  = "" ; 
		obj.NameValue(1,"USE_PROJNM" )  = "=선택 or 입력=" ;  
	}

	/******************************************************************************
		Description : 주문등록
	******************************************************************************/
	function ln_RegOrder(){
		window.location.href="<%=dirPath%>/Transfer/jsp/tr00202.jsp"; 
	}

	/******************************************************************************
		Description : 환율변환
	******************************************************************************/
	function ln_ChangeRate(){
		var ls_acnt = gcDs1.Sum(72,0,0);
		if (gcDs1.countrow<1)	alert("환율변환하실 정보가 없습니다");
		else if (ls_acnt<1)	alert("환율변환하실 주문정보를 선택하십시오.");
		else {
			var w = window.top.screen.width;
			var h = window.top.screen.height;
			var Lf=0, Tp=15;
			if(w>=600){Lf=(w-750);}
			if(h>=500){Tp=(h-570);}
				
			var pan = window.open("tr00101_e1.jsp","","top=200px,left=300px,resizable=no,width=340,height=180,scrollbars=no");
		}
	}

	/******************************************************************************
		Description : Cargo Mark 출력
	******************************************************************************/
	function ln_CargoMark(){
	
		if (gcDs1.countrow<1) return;
		
		var ls_order_no = gcDs1.namevalue(gcDs1.rowposition,"ORDER_NO");
		
		gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_sd1?NOH=Y&gstr1=" + ls_order_no;
		gcDs2.Reset();

		gcDsrpt1.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsCargoMark?NOH=Y&gstr1=" + ls_order_no;
		gcDsrpt1.Reset();
		
	}

	/******************************************************************************
		Description : 물품리스트
	******************************************************************************/
	function ln_Print(){

		if (gcDs1.countrow<1) return;

		gcds_report01.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s7?gstr1=" + gcDs1.namevalue(gcDs1.rowposition,"ORDER_NO");
		gcds_report01.Reset();

		gcds_report02.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s8?gstr1=" + gcDs1.namevalue(gcDs1.rowposition,"ORDER_NO");
		gcds_report02.Reset();

		var ls_format = "";

		ls_format += "<B>id=Header ,left=0,top=0 ,right=2870 ,bottom=770 ,face='Arial' ,size=10 ,penwidth=1";
		ls_format += "	<T>id='물품리스트' ,left=3 ,top=00 ,right=2870 ,bottom=160 ,face='굴림' ,size=25 ,bold=true</T>";

		var ls_top = new Array('200','270','340','410','480','550','620');

		for (var i=0; i<7; i++) ls_format += "	<L>left=30	 ,top=" + ls_top[i] + " ,right=880  ,bottom=" + ls_top[i] + " ,border=true</L>";
		for (var i=0; i<7; i++) ls_format += "	<L>left=960  ,top=" + ls_top[i] + " ,right=1860 ,bottom=" + ls_top[i] + " ,border=true</L>";
		for (var i=0; i<6; i++) ls_format += "	<L>left=1890 ,top=" + ls_top[i] + " ,right=2790 ,bottom=" + ls_top[i] + " ,border=true</L>";


		ls_format += "	<L>left=30    ,top=200 ,right=30   ,bottom=620 ,border=true</L>";
		ls_format += "	<L>left=960		,top=200 ,right=960	 ,bottom=620 ,border=true</L>";
		ls_format += "	<L>left=1890	,top=200 ,right=1890 ,bottom=550 ,border=true</L>";

		ls_format += "	<L>left=330   ,top=270 ,right=330  ,bottom=620 ,border=true</L>";
		ls_format += "	<L>left=1310	,top=270 ,right=1310 ,bottom=620 ,border=true</L>";
		ls_format += "	<L>left=2240	,top=270 ,right=2240 ,bottom=550 ,border=true</L>";

		ls_format += "	<L>left=880   ,top=200 ,right=880  ,bottom=620 ,border=true</L>";
		ls_format += "	<L>left=1860	,top=200 ,right=1860 ,bottom=620 ,border=true</L>";
		ls_format += "	<L>left=2790	,top=200 ,right=2790 ,bottom=550 ,border=true</L>";

		ls_format += "	<T>id='기본정보'		,left=35 ,top=200 ,right=880 ,bottom=270 ,face='굴림' ,size=10 ,bold=false, align=center</T>";
		ls_format += "	<T>id='프로젝트명'	,left=35 ,top=270 ,right=280 ,bottom=340 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='반출일자'		,left=35 ,top=340 ,right=280 ,bottom=410 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='상차/입고일' ,left=35 ,top=410 ,right=280 ,bottom=480 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='총투입대수'	,left=35 ,top=480 ,right=280 ,bottom=550 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='비고'				,left=35 ,top=550 ,right=280 ,bottom=620 ,face='굴림' ,size=10 ,bold=false, align=left</T>";

		ls_format += "	<C>id='PROJNM'	,left=340 ,top=270 ,right=880 ,bottom=340 ,face='굴림' ,size=10 ,bold=false, align=left</C>";
		ls_format += "	<C>id='ETD_DT'	,left=340 ,top=340 ,right=880 ,bottom=410 ,face='굴림' ,size=10 ,bold=false, align=left, Mask='XXXX/XX/XX'</C>";
		ls_format += "	<C>id='ETD_DT1' ,left=340 ,top=410 ,right=880 ,bottom=480 ,face='굴림' ,size=10 ,bold=false, align=left, Mask='XXXX/XX/XX'</C>";
		ls_format += "	<C>id='CAR_INFO',left=340 ,top=480 ,right=880 ,bottom=550 ,face='굴림' ,size=10 ,bold=false, align=left</C>";
		ls_format += "	<C>id='REMARK'	,left=340 ,top=550 ,right=880 ,bottom=620 ,face='굴림' ,size=10 ,bold=false, align=left</C>";

		ls_format += "	<T>id='송하인정보'		,			left=965 ,top=200 ,right=1890 ,bottom=270 ,face='굴림' ,size=10 ,bold=false, align=center</T>";
		ls_format += "	<T>id='업체명'	,						left=965 ,top=270 ,right=1890 ,bottom=340 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='담당자'	,						left=965 ,top=340 ,right=1890 ,bottom=410 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='전화번호' ,					left=965 ,top=410 ,right=1890 ,bottom=480 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='출하공장 담당자'	,		left=965 ,top=480 ,right=1890 ,bottom=550 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='출하공장 전화번호'	,	left=965 ,top=550 ,right=1890 ,bottom=620 ,face='굴림' ,size=10 ,bold=false, align=left</T>";

		ls_format += "	<C>id='VEND_NM'	,			left=1320 ,top=270 ,right=1890 ,bottom=340 ,face='굴림' ,size=10 ,bold=false, align=left</C>";
		ls_format += "	<C>id='SHIPPERPS'	,		left=1320 ,top=340 ,right=1890 ,bottom=410 ,face='굴림' ,size=10 ,bold=false, align=left</C>";
		ls_format += "	<C>id='SHIPPERTEL' ,	left=1320 ,top=410 ,right=1890 ,bottom=480 ,face='굴림' ,size=10 ,bold=false, align=left</C>";
		ls_format += "	<C>id='FAC_PERSON'	,	left=1320 ,top=480 ,right=1890 ,bottom=550 ,face='굴림' ,size=10 ,bold=false, align=left</C>";
		ls_format += "	<C>id='FAC_PRSTEL'	,	left=1320 ,top=550 ,right=1890 ,bottom=620 ,face='굴림' ,size=10 ,bold=false, align=left</C>";

		ls_format += "	<T>id='수하인정보',		left=1895 ,top=200 ,right=2790 ,bottom=270 ,face='굴림' ,size=10 ,bold=false, align=center</T>";
		ls_format += "	<T>id='업체명'	,			left=1895 ,top=270 ,right=2790 ,bottom=340 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='담당자'	,			left=1895 ,top=340 ,right=2790 ,bottom=410 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='전화번호' ,		left=1895 ,top=410 ,right=2790 ,bottom=480 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='주소'	,				left=1895 ,top=480 ,right=2790 ,bottom=550 ,face='굴림' ,size=10 ,bold=false, align=left</T>";

		ls_format += "	<C>id='RECIPIENT'	,		left=2250 ,top=270 ,right=2790 ,bottom=340 ,face='굴림' ,size=10 ,bold=false, align=left</C>";
		ls_format += "	<C>id='RECP_OWN'	,		left=2250 ,top=340 ,right=2790 ,bottom=410 ,face='굴림' ,size=10 ,bold=false, align=left</C>";
		ls_format += "	<C>id='RECP_TEL' ,		left=2250 ,top=410 ,right=2790 ,bottom=480 ,face='굴림' ,size=10 ,bold=false, align=left</C>";
		ls_format += "	<C>id='RECP_ADD'	,		left=2250 ,top=480 ,right=2790 ,bottom=550 ,face='굴림' ,size=10 ,bold=false, align=left</C>";

		ls_format += "	<X>left=30	,top=670 ,right=2790 ,bottom=770 ,border=true, bgcolor='#eeeeee'</X>";

		var li_line = 30;
		var li_line_f = 30;
		var li_left = new Array(80,300,250,200,200,250,250,250,200,250,250,279);
		var ls_left = new Array('NO','품명','규격','수량단위','수량','단가(원)','금액(원)','총용적(CBM)','총무게(KG)','비고(반입시\n반출일자)','상차지 상세정보','하차지 상세정보');
		for (var j=0; j<12; j++) {
			li_line = li_line + li_left[j];
			ls_format += "	<L>left=" + li_line + "	 ,top=670 ,right=" + li_line + "  ,bottom=770 ,border=true</L>";
			if (j<9) ls_format += "	<T>id='" + ls_left[j] + "',	left=" + li_line_f + " ,top=670 ,right=" + li_line + " ,bottom=770 ,face='굴림' ,size=10 ,bold=true, align=center, bgcolor='#eeeeee'</T>";
			li_line_f = li_line;
		}

		ls_format += "	<T>id='비고',	left=2015 ,top=660 ,right=2255 ,bottom=740 ,face='굴림' ,size=9 ,bold=true, align=center, bgcolor='#eeeeee'</T>";
		ls_format += "	<T>id='(반입시 반출일자)',	left=2015 ,top=710 ,right=2255 ,bottom=770 ,face='굴림' ,size=8.7 ,bold=true, align=center, bgcolor='#eeeeee'</T>";
		ls_format += "	<T>id='상차지',		left=2215 ,top=660 ,right=2555 ,bottom=740 ,face='굴림' ,size=9 ,bold=true, align=center, bgcolor='#eeeeee'</T>";
		ls_format += "	<T>id='상세정보',	left=2215 ,top=710 ,right=2555 ,bottom=770 ,face='굴림' ,size=9 ,bold=true, align=center, bgcolor='#eeeeee'</T>";
		ls_format += "	<T>id='하차지',		left=2515 ,top=660 ,right=2790 ,bottom=740 ,face='굴림' ,size=9 ,bold=true, align=center, bgcolor='#eeeeee'</T>";
		ls_format += "	<T>id='상세정보',	left=2515 ,top=710 ,right=2790 ,bottom=770 ,face='굴림' ,size=9 ,bold=true, align=center, bgcolor='#eeeeee'</T>";

		ls_format += "</B>";

		ls_format += "<B>id=Default ,left=0,top=0 ,right=70 ,bottom=60 ,face='Arial' ,size=9 ,penwidth=1";

		ls_format += "	<L>left=30	 ,top=0 ,right=30  ,bottom=60 ,border=true</L>";

		var li_line = 30;
		var li_left = new Array(80,300,250,200,200,250,250,250,200,250,250,279);
		for (var j=0; j<12; j++) {
			li_line = li_line + li_left[j];
			ls_format += "	<L>left=" + li_line + "	 ,top=0 ,right=" + li_line + "  ,bottom=60 ,border=true</L>";
		}

		ls_format += "	<C>id='{CURROW}',		left=30  ,top=0 ,right=110 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=right</C>";

		if (LINE_PART.bindcolval=="0002")	ls_format += "	<C>id='ARTC_KENM',		left=110 ,top=0 ,right=410 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=left</C>";
		else ls_format += "	<C>id='ARTC_NM',		left=110 ,top=0 ,right=410 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=left</C>";

		ls_format += "	<C>id='STN_SZNM',		left=410 ,top=0 ,right=660 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=left</C>";
		ls_format += "	<C>id='MINORNM',		left=660 ,top=0 ,right=860 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=left</C>";
		ls_format += "	<C>id='ARTC_CNT',		left=860 ,top=0 ,right=1060 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=right</C>";
		ls_format += "	<C>id='UNIT_PRICE',	left=1060 ,top=0 ,right=1310 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=right</C>";
		ls_format += "	<C>id='PRICE',			left=1310 ,top=0 ,right=1560 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=right</C>";
		ls_format += "	<C>id='TOT_CBM',		left=1660 ,top=0 ,right=1810 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=right</C>";
		ls_format += "	<C>id='TOT_WGHT',		left=1810 ,top=0 ,right=2010 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=right</C>";
		ls_format += "	<C>id='CANCLE_STS',	left=2020 ,top=0 ,right=2260 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=left</C>";
		ls_format += "	<C>id='LD_CARGONM',	left=2260 ,top=0 ,right=2510 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=left</C>";
		ls_format += "	<C>id='OFF_CARGONM',left=2510 ,top=0 ,right=2790 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=left</C>";

		ls_format += "	<L>left=30	 ,top=60 ,right=2790  ,bottom=60 ,border=true</L>";

		ls_format += "</B>";

		ls_format += "<B>id=Tail ,left=0,top=0 ,right=70 ,bottom=60 ,face='Arial' ,size=9 ,penwidth=1";

		ls_format += "	<L>left=30	 ,top=0 ,right=30  ,bottom=60 ,border=true</L>";

		var li_line = 30;
		var li_left = new Array(80,300,250,200,200,250,250,250,200,250,250,279);
		for (var j=0; j<12; j++) {
			li_line = li_line + li_left[j];
			ls_format += "	<L>left=" + li_line + "	 ,top=0 ,right=" + li_line + "  ,bottom=60 ,border=true</L>";
		}

		ls_format += "	<T>id='합계',		left=30  ,top=0 ,right=110 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=center</T>";
		ls_format += "	<X>left=110 ,top=0 ,right=860 ,bottom=60, bgcolor='#000000'</X>";

		ls_format += "	<T>id='" + gn_setint(gcds_report02.Sum(4,1,gcds_report02.countrow)) + "',		left=860 ,top=0 ,right=1060 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=right</T>";
		ls_format += "	<X>left=1060 ,top=0 ,right=1310 ,bottom=60, bgcolor='#000000'</X>";
		ls_format += "	<T>id='" + gn_setint(gcds_report02.Sum(6,1,gcds_report02.countrow)) + "',			left=1310 ,top=0 ,right=1560 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=right</T>";
		ls_format += "	<X>left=1560 ,top=0 ,right=2790 ,bottom=60, bgcolor='#000000'</X>";

		ls_format += "	<L>left=30	 ,top=60 ,right=2790  ,bottom=60 ,border=true</L>";

		ls_format += "</B>";

		gcrp_print.format = ls_format;
		gcrp_print.preview();
	}

	/******************************************************************************
		Description : 화물 인수증
	******************************************************************************/
	function ln_PrintFR(){

		if (gcDs1.countrow<1) return;

		gcds_report01.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s7?gstr1=" + gcDs1.namevalue(gcDs1.rowposition,"ORDER_NO");
		gcds_report01.Reset();

		gcds_report02.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s8?gstr1=" + gcDs1.namevalue(gcDs1.rowposition,"ORDER_NO");
		gcds_report02.Reset();

		var ls_format = "";

		ls_format += "<B>id=Header ,left=0,top=0 ,right=2870 ,bottom=770 ,face='Arial' ,size=10 ,penwidth=1";
		ls_format += "	<T>id='화물인수증' ,left=3 ,top=00 ,right=2870 ,bottom=160 ,face='굴림' ,size=25 ,bold=true</T>";

		var ls_top = new Array('200','270','340','410','480','550','620');

		for (var i=0; i<7; i++) ls_format += "	<L>left=30	 ,top=" + ls_top[i] + " ,right=880  ,bottom=" + ls_top[i] + " ,border=true</L>";
		for (var i=0; i<7; i++) ls_format += "	<L>left=960  ,top=" + ls_top[i] + " ,right=1860 ,bottom=" + ls_top[i] + " ,border=true</L>";
		for (var i=0; i<6; i++) ls_format += "	<L>left=1890 ,top=" + ls_top[i] + " ,right=2790 ,bottom=" + ls_top[i] + " ,border=true</L>";


		ls_format += "	<L>left=30    ,top=200 ,right=30   ,bottom=620 ,border=true</L>";
		ls_format += "	<L>left=960		,top=200 ,right=960	 ,bottom=620 ,border=true</L>";
		ls_format += "	<L>left=1890	,top=200 ,right=1890 ,bottom=550 ,border=true</L>";

		ls_format += "	<L>left=330   ,top=270 ,right=330  ,bottom=620 ,border=true</L>";
		ls_format += "	<L>left=1310	,top=270 ,right=1310 ,bottom=620 ,border=true</L>";
		ls_format += "	<L>left=2240	,top=270 ,right=2240 ,bottom=550 ,border=true</L>";

		ls_format += "	<L>left=880   ,top=200 ,right=880  ,bottom=620 ,border=true</L>";
		ls_format += "	<L>left=1860	,top=200 ,right=1860 ,bottom=620 ,border=true</L>";
		ls_format += "	<L>left=2790	,top=200 ,right=2790 ,bottom=550 ,border=true</L>";

		ls_format += "	<T>id='기본정보'		,left=35 ,top=200 ,right=880 ,bottom=270 ,face='굴림' ,size=10 ,bold=false, align=center</T>";
		ls_format += "	<T>id='프로젝트명'	,left=35 ,top=270 ,right=280 ,bottom=340 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='반출일자'		,left=35 ,top=340 ,right=280 ,bottom=410 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='상차/입고일' ,left=35 ,top=410 ,right=280 ,bottom=480 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='총투입대수'	,left=35 ,top=480 ,right=280 ,bottom=550 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='비고'				,left=35 ,top=550 ,right=280 ,bottom=620 ,face='굴림' ,size=10 ,bold=false, align=left</T>";

		ls_format += "	<C>id='PROJNM'	,left=340 ,top=270 ,right=880 ,bottom=340 ,face='굴림' ,size=10 ,bold=false, align=left</C>";
		ls_format += "	<C>id='ETD_DT'	,left=340 ,top=340 ,right=880 ,bottom=410 ,face='굴림' ,size=10 ,bold=false, align=left, Mask='XXXX/XX/XX'</C>";
		ls_format += "	<C>id='ETD_DT1' ,left=340 ,top=410 ,right=880 ,bottom=480 ,face='굴림' ,size=10 ,bold=false, align=left, Mask='XXXX/XX/XX'</C>";
		ls_format += "	<C>id='CAR_INFO',left=340 ,top=480 ,right=880 ,bottom=550 ,face='굴림' ,size=10 ,bold=false, align=left</C>";
		ls_format += "	<C>id='REMARK'	,left=340 ,top=550 ,right=880 ,bottom=620 ,face='굴림' ,size=10 ,bold=false, align=left</C>";

		ls_format += "	<T>id='송하인정보'		,			left=965 ,top=200 ,right=1890 ,bottom=270 ,face='굴림' ,size=10 ,bold=false, align=center</T>";
		ls_format += "	<T>id='업체명'	,						left=965 ,top=270 ,right=1890 ,bottom=340 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='담당자'	,						left=965 ,top=340 ,right=1890 ,bottom=410 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='전화번호' ,					left=965 ,top=410 ,right=1890 ,bottom=480 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='출하공장 담당자'	,		left=965 ,top=480 ,right=1890 ,bottom=550 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='출하공장 전화번호'	,	left=965 ,top=550 ,right=1890 ,bottom=620 ,face='굴림' ,size=10 ,bold=false, align=left</T>";

		ls_format += "	<C>id='VEND_NM'	,			left=1320 ,top=270 ,right=1890 ,bottom=340 ,face='굴림' ,size=10 ,bold=false, align=left</C>";
		ls_format += "	<C>id='SHIPPERPS'	,		left=1320 ,top=340 ,right=1890 ,bottom=410 ,face='굴림' ,size=10 ,bold=false, align=left</C>";
		ls_format += "	<C>id='SHIPPERTEL' ,	left=1320 ,top=410 ,right=1890 ,bottom=480 ,face='굴림' ,size=10 ,bold=false, align=left</C>";
		ls_format += "	<C>id='FAC_PERSON'	,	left=1320 ,top=480 ,right=1890 ,bottom=550 ,face='굴림' ,size=10 ,bold=false, align=left</C>";
		ls_format += "	<C>id='FAC_PRSTEL'	,	left=1320 ,top=550 ,right=1890 ,bottom=620 ,face='굴림' ,size=10 ,bold=false, align=left</C>";

		ls_format += "	<T>id='수하인정보',		left=1895 ,top=200 ,right=2790 ,bottom=270 ,face='굴림' ,size=10 ,bold=false, align=center</T>";
		ls_format += "	<T>id='업체명'	,			left=1895 ,top=270 ,right=2790 ,bottom=340 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='담당자'	,			left=1895 ,top=340 ,right=2790 ,bottom=410 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='전화번호' ,		left=1895 ,top=410 ,right=2790 ,bottom=480 ,face='굴림' ,size=10 ,bold=false, align=left</T>";
		ls_format += "	<T>id='주소'	,				left=1895 ,top=480 ,right=2790 ,bottom=550 ,face='굴림' ,size=10 ,bold=false, align=left</T>";

		ls_format += "	<C>id='RECIPIENT'	,		left=2250 ,top=270 ,right=2790 ,bottom=340 ,face='굴림' ,size=10 ,bold=false, align=left</C>";
		ls_format += "	<C>id='RECP_OWN'	,		left=2250 ,top=340 ,right=2790 ,bottom=410 ,face='굴림' ,size=10 ,bold=false, align=left</C>";
		ls_format += "	<C>id='RECP_TEL' ,		left=2250 ,top=410 ,right=2790 ,bottom=480 ,face='굴림' ,size=10 ,bold=false, align=left</C>";
		ls_format += "	<C>id='RECP_ADD'	,		left=2250 ,top=480 ,right=2790 ,bottom=550 ,face='굴림' ,size=10 ,bold=false, align=left</C>";

		ls_format += "	<X>left=30	,top=670 ,right=2790 ,bottom=770 ,border=true, bgcolor='#eeeeee'</X>";

		var li_line = 30;
		var li_line_f = 30;
		var li_left = new Array(80,300,250,200,200,250,250,250,200,250,250,279);
		var ls_left = new Array('NO','품명','규격','수량단위','수량','단가(원)','금액(원)','총용적(CBM)','총무게(KG)','비고(반입시\n반출일자)','상차지 상세정보','하차지 상세정보');
		for (var j=0; j<12; j++) {
			li_line = li_line + li_left[j];
			ls_format += "	<L>left=" + li_line + "	 ,top=670 ,right=" + li_line + "  ,bottom=770 ,border=true</L>";
			if (j<9) ls_format += "	<T>id='" + ls_left[j] + "',	left=" + li_line_f + " ,top=670 ,right=" + li_line + " ,bottom=770 ,face='굴림' ,size=10 ,bold=true, align=center, bgcolor='#eeeeee'</T>";
			li_line_f = li_line;
		}

		ls_format += "	<T>id='비고',	left=2015 ,top=660 ,right=2255 ,bottom=740 ,face='굴림' ,size=9 ,bold=true, align=center, bgcolor='#eeeeee'</T>";
		ls_format += "	<T>id='(반입시 반출일자)',	left=2015 ,top=710 ,right=2255 ,bottom=770 ,face='굴림' ,size=8.7 ,bold=true, align=center, bgcolor='#eeeeee'</T>";
		ls_format += "	<T>id='상차지',		left=2215 ,top=660 ,right=2555 ,bottom=740 ,face='굴림' ,size=9 ,bold=true, align=center, bgcolor='#eeeeee'</T>";
		ls_format += "	<T>id='상세정보',	left=2215 ,top=710 ,right=2555 ,bottom=770 ,face='굴림' ,size=9 ,bold=true, align=center, bgcolor='#eeeeee'</T>";
		ls_format += "	<T>id='하차지',		left=2515 ,top=660 ,right=2790 ,bottom=740 ,face='굴림' ,size=9 ,bold=true, align=center, bgcolor='#eeeeee'</T>";
		ls_format += "	<T>id='상세정보',	left=2515 ,top=710 ,right=2790 ,bottom=770 ,face='굴림' ,size=9 ,bold=true, align=center, bgcolor='#eeeeee'</T>";

		ls_format += "</B>";

		ls_format += "<B>id=Default ,left=0,top=0 ,right=70 ,bottom=60 ,face='Arial' ,size=9 ,penwidth=1";

		ls_format += "	<L>left=30	 ,top=0 ,right=30  ,bottom=60 ,border=true</L>";

		var li_line = 30;
		var li_left = new Array(80,300,250,200,200,250,250,250,200,250,250,279);
		for (var j=0; j<12; j++) {
			li_line = li_line + li_left[j];
			ls_format += "	<L>left=" + li_line + "	 ,top=0 ,right=" + li_line + "  ,bottom=60 ,border=true</L>";
		}

		ls_format += "	<C>id='{CURROW}',		left=30  ,top=0 ,right=110 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=right</C>";
		ls_format += "	<C>id='ARTC_NM',		left=110 ,top=0 ,right=410 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=left</C>";
		ls_format += "	<C>id='STN_SZNM',		left=410 ,top=0 ,right=660 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=left</C>";
		ls_format += "	<C>id='MINORNM',		left=660 ,top=0 ,right=860 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=left</C>";
		ls_format += "	<C>id='ARTC_CNT',		left=860 ,top=0 ,right=1060 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=right</C>";
		ls_format += "	<C>id='UNIT_PRICE',	left=1060 ,top=0 ,right=1310 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=right</C>";
		ls_format += "	<C>id='PRICE',			left=1310 ,top=0 ,right=1560 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=right</C>";
		ls_format += "	<C>id='TOT_CBM',		left=1660 ,top=0 ,right=1810 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=right</C>";
		ls_format += "	<C>id='TOT_WGHT',		left=1810 ,top=0 ,right=2010 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=right</C>";
		ls_format += "	<C>id='CANCLE_STS',	left=2020 ,top=0 ,right=2260 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=left</C>";
		ls_format += "	<C>id='LD_CARGONM',	left=2260 ,top=0 ,right=2510 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=left</C>";
		ls_format += "	<C>id='OFF_CARGONM',left=2510 ,top=0 ,right=2790 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=left</C>";

		ls_format += "	<L>left=30	 ,top=60 ,right=2790  ,bottom=60 ,border=true</L>";

		ls_format += "</B>";

		ls_format += "<B>id=Tail ,left=0,top=0 ,right=70 ,bottom=60 ,face='Arial' ,size=9 ,penwidth=1";

		ls_format += "	<L>left=30	 ,top=0 ,right=30  ,bottom=60 ,border=true</L>";

		var li_line = 30;
		var li_left = new Array(80,300,250,200,200,250,250,250,200,250,250,279);
		for (var j=0; j<12; j++) {
			li_line = li_line + li_left[j];
			ls_format += "	<L>left=" + li_line + "	 ,top=0 ,right=" + li_line + "  ,bottom=60 ,border=true</L>";
		}

		ls_format += "	<T>id='합계',		left=30  ,top=0 ,right=110 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=center</T>";
		ls_format += "	<X>left=110 ,top=0 ,right=860 ,bottom=60, bgcolor='#000000'</X>";

		ls_format += "	<T>id='" + gn_setint(gcds_report02.Sum(4,1,gcds_report02.countrow)) + "',		left=860 ,top=0 ,right=1060 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=right</T>";
		ls_format += "	<X>left=1060 ,top=0 ,right=1310 ,bottom=60, bgcolor='#000000'</X>";
		ls_format += "	<T>id='" + gn_setint(gcds_report02.Sum(6,1,gcds_report02.countrow)) + "',			left=1310 ,top=0 ,right=1560 ,bottom=60 ,face='굴림' ,size=9 ,bold=false, align=right</T>";
		ls_format += "	<X>left=1560 ,top=0 ,right=2790 ,bottom=60, bgcolor='#000000'</X>";

		ls_format += "	<L>left=30	 ,top=60 ,right=2790  ,bottom=60 ,border=true</L>";

		ls_format += "</B>";

		ls_format += "<B>id=Footer ,left=0,top=1580 ,right=2870 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1";
		ls_format += "	<T>id='송하인(대리인)',	left=30 ,top=30 ,right=280 ,bottom=100 ,face='굴림' ,size=10 ,bold=true, align=right</T>";
		ls_format += "	<T>id='일 시 :',	left=30 ,top=100 ,right=280 ,bottom=170 ,face='굴림' ,size=10 ,bold=false, align=right</T>";
		ls_format += "	<T>id='회사명 :',	left=30 ,top=170 ,right=280 ,bottom=240 ,face='굴림' ,size=10 ,bold=false, align=right</T>";
		ls_format += "	<T>id='성 명 : ',	left=30 ,top=240 ,right=280 ,bottom=310 ,face='굴림' ,size=10 ,bold=false, align=right</T>";

		ls_format += "	<L>left=280 ,top=230 ,right=700 ,bottom=230 ,face='굴림' ,size=10 ,bold=false, align=right</L>";
		ls_format += "	<L>left=280 ,top=300 ,right=700 ,bottom=300 ,face='굴림' ,size=10 ,bold=false, align=right</L>";
		ls_format += "	<T>id='(서명)',			left=280 ,top=240 ,right=700 ,bottom=310 ,face='굴림' ,size=9 ,bold=false, align=right</T>";

		ls_format += "	<T>id='물류센터(창고업자)',	left=630 ,top=30 ,right=980 ,bottom=100 ,face='굴림' ,size=10 ,bold=true, align=right</T>";
		ls_format += "	<T>id='일  시 :',	left=730 ,top=100  ,right=980 ,bottom=170 ,face='굴림' ,size=10 ,bold=false, align=right</T>";
		ls_format += "	<T>id='회사명 :',	left=730 ,top=170 ,right=980 ,bottom=240 ,face='굴림' ,size=10 ,bold=false, align=right</T>";
		ls_format += "	<T>id='성  명 :',	left=730 ,top=240 ,right=980 ,bottom=310 ,face='굴림' ,size=10 ,bold=false, align=right</T>";

		ls_format += "	<L>left=980 ,top=230 ,right=1430 ,bottom=230 ,face='굴림' ,size=10 ,bold=false, align=right</L>";
		ls_format += "	<L>left=980 ,top=300 ,right=1430 ,bottom=300 ,face='굴림' ,size=10 ,bold=false, align=right</L>";
		ls_format += "	<T>id='(서명)',			left=980 ,top=240 ,right=1430 ,bottom=310 ,face='굴림' ,size=9 ,bold=false, align=right</T>";

		ls_format += "	<T>id='운송사',				left=1430 ,top=30	 ,right=1680 ,bottom=100 ,face='굴림' ,size=10 ,bold=true, align=right</T>";
		ls_format += "	<T>id='일      시 :',	left=1430 ,top=100  ,right=1680 ,bottom=170 ,face='굴림' ,size=10 ,bold=false, align=right</T>";
		ls_format += "	<T>id='차량번호 :',		left=1430 ,top=170 ,right=1680 ,bottom=240 ,face='굴림' ,size=10 ,bold=false, align=right</T>";
		ls_format += "	<T>id='성      명 :',	left=1430 ,top=240 ,right=1680 ,bottom=310 ,face='굴림' ,size=10 ,bold=false, align=right</T>";

		ls_format += "	<L>left=1680 ,top=230 ,right=2130 ,bottom=230 ,face='굴림' ,size=10 ,bold=false, align=right</L>";
		ls_format += "	<L>left=1680 ,top=300 ,right=2130 ,bottom=300 ,face='굴림' ,size=10 ,bold=false, align=right</L>";
		ls_format += "	<T>id='(서명)',			left=1680 ,top=240 ,right=2130 ,bottom=310 ,face='굴림' ,size=9 ,bold=false, align=right</T>";

		ls_format += "	<T>id='수하인(대리인)',	left=2130 ,top=30 ,	right=2380 ,bottom=100 ,face='굴림' ,size=10 ,bold=true, align=right</T>";
		ls_format += "	<T>id='일   시 :',			left=2130 ,top=100  ,right=2380 ,bottom=170 ,face='굴림' ,size=10 ,bold=false, align=right</T>";
		ls_format += "	<T>id='회사명 :',				left=2130 ,top=170 ,right=2380 ,bottom=240 ,face='굴림' ,size=10 ,bold=false, align=right</T>";
		ls_format += "	<T>id='성   명 :',			left=2130 ,top=240 ,right=2380 ,bottom=310 ,face='굴림' ,size=10 ,bold=false, align=right</T>";

		ls_format += "	<L>left=2380 ,top=230 ,right=2780 ,bottom=230 ,face='굴림' ,size=10 ,bold=false, align=right</L>";
		ls_format += "	<L>left=2380 ,top=300 ,right=2780 ,bottom=300 ,face='굴림' ,size=10 ,bold=false, align=right</L>";
		ls_format += "	<T>id='(서명)',			left=2380 ,top=240 ,right=2780 ,bottom=310 ,face='굴림' ,size=9 ,bold=false, align=right</T>";

		ls_format += "</B>";
		
		gcrp_print.format = ls_format;
		gcrp_print.preview();


	}
	
	/******************************************************************************
		Description : 반출 물품리스트
	******************************************************************************/
	function ln_Excel(){
		if (gcDs1.countrow<1) return;

		var row = gcDs1.rowposition;
		if (row<1) return;

		var seq = 1;
		var gorder = "";

		for (var i=1; i<=gcDs1.countrow; i++){
			if (gcDs1.namevalue(i,"RATE_FLAG")==1) {
				if (seq==1) {
					gorder = "'" + gcDs1.namevalue(i,"order_no") + "'";
					var etd_dt = gcDs1.namevalue(i,"etd_dt");
					var line_part = gcDs1.namevalue(i,"line_part");

					if (line_part == '0001') line_part = "A";
					else if (line_part == '0002') line_part = "B";
				} else {
					gorder += ",'" + gcDs1.namevalue(i,"order_no") + "'";
				}
				seq++;
			}
		}

		if (seq==1) return;

		var surl = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s9?v_str1=" + gorder + "&v_str2=" + gn_Replace(gcurdate,"-") + "&v_str3=" + etd_dt + "&v_str4=" + line_part;

		window.open(surl,"_self","toolbar=no,menubar=no,scrollbars=no,resizable=yes,width=0,height=0,left=999999,top=999999");
	}
 </SCRIPT> 

 <script language=JavaScript for=gcDs1 event=OnLoadCompleted(rowcnt)>
	Chang_Format() ; 
</script>

<script language=JavaScript for=gcGR1 event=OnClick(row,colid)>
	if (gcDs1.countrow<1) return;

	if (row<1) {
		if (colid=="RATE_FLAG"){
			if (gcGR1.ColumnProp(colid,'HeadCheck')=="TRUE") {
				gcGR1.ColumnProp(colid,'HeadCheck') = "false";
				for (var i=1; i<=gcDs1.countrow; i++) gcDs1.namevalue(i,colid) = 0;
			} else {
				gcGR1.ColumnProp(colid,'HeadCheck') = "true";
				for (var i=1; i<=gcDs1.countrow; i++) {
					if (gcDs1.namevalue(i,"ORDER_STS")!="0005"||gcDs1.namevalue(i,"ORDER_STS")!="0006") gcDs1.namevalue(i,colid) = 1;
				}
			}
		}
	} else {
		if (colid=="RATE_FLAG"){
			if (gcDs1.namevalue(row,"ORDER_STS") != "0005" || gcDs1.namevalue(row,"ORDER_STS") != "0006") {
				if (gcDs1.namevalue(row,colid) == 1) gcDs1.namevalue(row,colid) = 0;
				else gcDs1.namevalue(row,colid) = 1;
			} else {
				alert("이미 상차된 정보입니다.");
			}
		}
	}
</script>

<script language=JavaScript for=gcGR1 event=OnDblClick(row,colid)>
	if (row<1) return;

	get_cookdata();

	if (gcDs1.namevalue(row,"ETD_DT") < gn_Replace(gcurdate,"-")) {
		alert("이미 반입된 주문정보입니다.");

	}

	if (gcDs1.namevalue(row,"ETD_DT") == "0002") {
		alert("복짐인 경우 담당자 승인을 받으셔야 합니다.");
		return;
	}


		var result="";
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;

	    arrParam[0]="update1";
	    arrParam[1]=gcDs1.namevalue(row,"ORDER_NO");


		strURL = "<%=dirPath%>/Transfer/jsp/tr00202.jsp?gstr1=update&gstr2="+gcDs1.NameValue(row,"ORDER_NO") ;  
		
		strPos = "dialogWidth:900px;dialogHeight:700px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
		
		result = showModalDialog(strURL,arrParam,strPos);
	
	
</script>

<script language=JavaScript for=gcDs_etc1 event=OnLoadCompleted(rowcnt)> 
	AddChoice(gcDs_etc1) ; 
	LINE_PART.Index = 0 ; 
</script>

<script language=JavaScript for=gcDs_etc2 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc2) ; 
	DLVL_TYPE.index = 0; 
</script> 

<script language=JavaScript for=gcDs_etc3 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc3) ; 
	CARGO_TYPE.Index = 0 ; 
</script>

<script language=JavaScript for=gcDsrpt1 event=OnLoadCompleted(rowcnt)>
	var goods_cnt = "";
	for (i=1;i<=gcDs2.CountRow; i++){
		if( i == 1)	goods_cnt = gcDs2.NameValue(i,"ARTC_NM") + ':' + gcDs2.NameValue(i,"ARTC_CNT");
		else goods_cnt = goods_cnt + ',' +  gcDs2.NameValue(i,"ARTC_NM") + ':' + gcDs2.NameValue(i,"ARTC_CNT") ;
	}

	gcDsrpt1.NameValue(1,"GOODS")  = goods_cnt ; 
	gcRpt01.Preview(); 
</script>

<script language=JavaScript for=LINE_PART event=OnSelChange2(row)>
	gcDs_etc11.Filter();
</script>

<script language=JavaScript for=gcDs_etc11 event=onFilter(row)>
	if (gcDs_etc11.NameValue(row,"LINE_PART") == LINE_PART.BindColVal) return true;
	else return false;
</script>

<script language=JavaScript for=gcDs_etc11 event=OnRowsetChanged()>
	if (gcDs_etc11.namevalue(1,"TR_PROJECT")!=""){
		AddChoiceProjct(gcDs_etc11) ; 
		PROJECT.Index = 0 ; 
	} else {
		gcDs_etc11.UndoAll();
	}
</script>

 <!-----------------------------------------------------------------------------
	  DESCRIPTION : STATUS BAR VISIBLE
------------------------------------------------------------------------------>
<script language=JavaScript for=gcDs1 event="OnLoadStarted()">
	OnStatusStart() ; 
 </script> 
<!-----------------------------------------------------------------------------
	  DESCRIPTION : STATUS BAR HIDDEN
------------------------------------------------------------------------------>
<script language=JavaScript for=gcDs1  event="onloadCompleted(row,colid)">
		TheStatusEnd(row) ; 
</script>

<script language=JavaScript for=gcTr1  event="onSuccess()">
	alert("선택하신 정보를 삭제하였습니다.");
</script>

<script language=JavaScript for=gcTr1  event="onFail()">
	alert(gcTr1.errormsg);
</script>

<script language=JavaScript for= SEARCH_TYPE event=OnSelChange2()>
	gcDs1.ClearAll();
	Chang_Format();
</script>


<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s07.jsp"  flush="true"/>
<BODY>
	<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td width="876" align="right" background="<%=dirPath%>/Common/img/com_t_bg.gif" style="padding-top:4px;">
				<img src="<%=dirPath%>/Common/img/btn/btn_cargomark.gif" style="cursor:hand" onclick="ln_CargoMark()">
				<img src="<%=dirPath%>/Common/img/btn/btn_order.gif" style="cursor:hand" onclick="ln_RegOrder()">
				<img src="<%=dirPath%>/Common/img/btn/btn_changerate.gif" style="cursor:hand" onclick="ln_ChangeRate()">
				<img src="<%=dirPath%>/Common/img/btn/btn_excel_d.gif" style="cursor:hand" onclick="ln_Excel();">
				<img src="<%=dirPath%>/Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="if (gcDs1.countrow>0) ExcelDialog(gcGR1,'주문정보');">
				<img src="<%=dirPath%>/Common/img/btn/btn_printfr.gif" style="cursor:hand" onclick="ln_PrintFR()">
				<img src="<%=dirPath%>/Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_Delete()">
				<img src="<%=dirPath%>/Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
			</td>
		</tr>
		<tr><td height="1" colspan=2></td></tr>
		<tr>
			<td colspan=2>
				<table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab11_left" style="height:30px;" bgcolor="#eeeeee">&nbsp;반입일자</td>
						<td class="tab21">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=FROM_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:6px; width:65px; height:17px; font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="<%=dirPath%>/Common/img/btn_calendar.gif" style="position:relative; left:8px;top:2px;cursor:hand" onclick="__GetCallCalendar('FROM_DATE', 'Text');">&nbsp;&nbsp;~&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=TO_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:2px;top:6px; width:65px; height:17px; font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      		value="false">
								<param name=Format	      		value="YYYY/MM/DD">
								<param name=PromptChar	  	value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="<%=dirPath%>/Common/img/btn_calendar.gif" style="position:relative; left:4px;top:2px;cursor:hand" onclick="__GetCallCalendar('TO_DATE', 'Text');">
						</td>
						<td class="tab11_left" bgcolor="#eeeeee">&nbsp;Project명</td>
						<td class="tab21" align='left'>
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=LINE_PART  style='border:0;position:relative;left:8px;top:2px;width:150px;height:200' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value=gcDs_etc1>  
								<param name=SearchColumn		value=MINORNM>
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value=True>
								<param name=ListExprFormat	value="MINORNM^0^150">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value=0>
								<param name=InheritColor		value="true"> 
								<param name=ComboStyle			value=2>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td class="tab11_left" bgcolor="#eeeeee">&nbsp;조회구분</td>
						<td class="tab13_left" style="width:240px;">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=SEARCH_TYPE classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style='width:100;position:relative;left:8px;top:2px'>
								<param name=CBData					value="A^주문별,B^차량별,C^상하차지별">
								<param name=CBDataColumns		value="code,name">
								<param name=SearchColumn		value=name>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="name^0^100">								
								<param name=BindColumn			value="code">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
					<tr>
						<td class="tab11_left" style="height:30px;" bgcolor="#eeeeee">&nbsp;주문번호</td>
						<td class="tab11_left" align='left'>
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ORDER_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:6px; width:180px; height:17px; font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="##############">
								<param name=PromptChar	  value="_">
								<param name=UpperFlag   value=1> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td class="tab11_left" bgcolor="#eeeeee">&nbsp;신청업체명</td>
						<td class="tab11_left" align='left'><input id="CUST_CDNM" name="CUST_CDNM" type="text" class="txt11" style='width:150;position:relative;left:8px;top:0px;'></td>
						<td class="tab11_left" bgcolor="#eeeeee">&nbsp;물류비 부담</td>
						<td class="tab22">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=PROJECT  style='border:0;position:relative;left:8px;top:2px;width:220px;height:300' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value="gcDs_etc11">  
								<param name=SearchColumn		value="USE_PROJNM">
								<param name=SortColumn			value="TR_PROJECT"> 
								<param name=ListExprFormat	value="USE_PROJNM^0^195">
								<param name=BindColumn			value="TR_PROJECT">
								<param name=InheritColor		value="true"> 
								<param name=ComboStyle			value="2">
							</OBJECT>
							<%=HDConstant.COMMENT_END%> 
						</td>
					</tr>
					<tr>
						<td class="tab12_left" style="height:30px" bgcolor="#eeeeee">&nbsp;상태구분</td>
						<td class="tab12_left" align='left'>
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=CARGO_TYPE  style='border:0;position:relative;left:8px;top:1px;width:120px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value=gcDs_etc3>  
								<param name=SearchColumn		value=MINORNM>
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value=True>
								<param name=ListExprFormat	value="MINORNM^0^120">								
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value=0>
								<param name=InheritColor		value="true"> 
								<param name=ComboStyle			value=2>
							</OBJECT>
							<%=HDConstant.COMMENT_END%> 
						</td>
						<td class="tab12_left" bgcolor="#eeeeee">&nbsp;적재구분</td>
						<td class="tab12_left"  >
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=DLVL_TYPE  style='border:0;position:relative;left:8px;top:1px;width:120px;height:150' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value=gcDs_etc2>  
								<param name=SearchColumn		value=MINORNM>
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value=True>
								<param name=ListExprFormat	value="MINORNM^0^120">								
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value=0>
								<param name=InheritColor		value="true"> 
								<param name=ComboStyle			value=2>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td class="tab12_left" bgcolor="#eeeeee">&nbsp;실화주명</td>
						<td><input id="SHIPPER_NM" name="SHIPPER_NM" type="text" class="txt11" style='width:220;position:relative;left:8px;top:0px;ime-mode:active'></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height=5px></td></tr>
		<tr>
			<td colspan=2> 
				<table  cellpadding="0" cellspacing="0" border="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:0 solid #708090">
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcGR1 style="width:875;height:380px;border:1 solid #777777;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"   VALUE="20">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="false">
								<param name="AllShowEdit" VALUE="true">
								<param name="ColSizing"  value="true">  
								<PARAM NAME="Format"			VALUE="  
								">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr> 
				</table> 
			</td>
		</tr>
		<tr>
			<td colspan=2> 
				<table id=tb_detail cellpadding="0" cellspacing="0" border="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090;" style="display:none">
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=Grid2 style="width:875;height:189px;border:1 solid #777777;display:none" viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_educ">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="true">
								<param name="AllShowEdit" VALUE="true">
								<PARAM NAME="Format"			VALUE="  
									<C> Name='No.' ID=GRAYY HeadAlign=Center HeadBgColor=#eeeeee Width=30  align=center</C> 
									<C> Name='적재차량' ID=GRAYY HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center</C> 
									<C> Name='상차지'		ID=PERFECT HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right</C> 
									<C> Name='하차지' ID=GRAYY HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=center</C> 
									<C> Name='HSCODE' ID=SCHNM  	HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left </C> 
									<C> Name='품명'		ID=EDCCD  	HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left, editstyle=LookUp data='gcds_hreduc:minorcd:minornm'</C>  
									<C> Name='규격' ID=CITY		HeadAlign=Center HeadBgColor=#eeeeee Width=100 align=left </C>
									<C> Name='단위'		ID=PGCCD	HeadAlign=Center HeadBgColor=#eeeeee Width=100 align=left, editstyle=LookUp data='gcds_preduc:minorcd:minornm'</C>
									<C> Name='수량'		ID=EDCDIV HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left, editstyle=LookUp data='gcds_greduc:minorcd:minornm' </C> 
									<C> Name='단가'		ID=AVRUNI HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right</C>
									<C> Name='금액'		ID=AVRUNI HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right</C> 
								">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr> 
				</table> 

			</td>
		</tr>
	</table>
<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcRpt01 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"	value="gcDsrpt1">
	<param name="DetailDataID"	value="gcDsrpt1">		
	<param name="PaperSize"			value="A4">		
	<param name="LandScape"     value="false"> 
	<param name="Format"				value="
		<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=516 ,face='Arial' ,size=10 ,penwidth=1
			<T>id='CARGO MARK' ,left=3 ,top=219 ,right=2000 ,bottom=381 ,face='Times New Roman' ,size=35 ,bold=true ,underline=true ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=1731 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=194 ,top=44 ,right=1856 ,bottom=456 ,border=true</X>
			<C>id='Project', left=222, top=75, right=1831, bottom=416, face='Arial', size=21, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='REMARK', left=753, top=1444, right=1778, bottom=1691, align='left', face='Arial', size=13, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
			<T>id='출   경   일  : ' ,left=200 ,top=637 ,right=741 ,bottom=741 ,align='left' ,face='새굴림' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='발주업체명   : ' ,left=197 ,top=912 ,right=738 ,bottom=1016 ,align='left' ,face='새굴림' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='품         명  : ' ,left=197 ,top=1187 ,right=738 ,bottom=1291 ,align='left' ,face='새굴림' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='수         량  : ' ,left=197 ,top=1325 ,right=738 ,bottom=1428 ,align='left' ,face='새굴림' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='비         고  : ' ,left=197 ,top=1462 ,right=738 ,bottom=1566 ,align='left' ,face='새굴림' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CONSIGNEE', left=753, top=784, right=1428, bottom=887, align='left', face='Arial', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='ETD_DT', left=753, top=637, right=1428, bottom=741, align='left' ,mask='XXXX-XX-XX', face='Arial', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<T>id='수   하   인  : ' ,left=197 ,top=784 ,right=738 ,bottom=887 ,align='left' ,face='새굴림' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='SHIPPER_NM', left=753, top=912, right=1428, bottom=1016, align='left', face='Arial', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='공급업체명   : ' ,left=197 ,top=1050 ,right=738 ,bottom=1153 ,align='left' ,face='새굴림' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CUST_NM', left=753, top=1050, right=1428, bottom=1153, align='left', face='Arial', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='ORDER_NO', left=753, top=491, right=1428, bottom=594, align='left', face='Arial', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='주 문 번 호  : ' ,left=200 ,top=491 ,right=741 ,bottom=594 ,align='left' ,face='새굴림' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='GOODS', left=753, top=1203, right=1775, bottom=1428, align='left', face='Arial', size=13, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true, Dec=0</C>
		</B>
		<B>id=Footer ,left=0 ,top=2395 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
			<I>id='Image' ,left=666 ,top=22 ,right=1244 ,bottom=269</I>
		</B>
	">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_report01">
	<param name="DetailDataID"			value="gcds_report02">		
	<param name="AllowBandOversize" value="true">
	<param name="PaperSize"					value="A4">		
	<param name="LandScape"					value="true"> 
</OBJECT>
<%=HDConstant.COMMENT_END%>

</BODY>
</HTML>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

