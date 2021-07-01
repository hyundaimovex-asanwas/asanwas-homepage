<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명   : 블럭신청
 * 프로그램ID    : RM510I
 * J  S  P      : rm510i
 * 서 블 릿     : RM510I
 * 작 성 자     : 안준성
 * 작 성 일     : 2006-06-15
 * 기능정의      : 블럭신청 (조회, 저장, 취소)
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

	//날짜 기본값
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());
	date.add(date.MONTH,1);
	String lastday = m_today.format(date.getTime());
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>

<%
/*=============================================================================
            Developer Java Script
=============================================================================*/
%>
   <script language="javascript">
        var v_job = "H";
        var div='';
   /*
    * 페이지로딩
    */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		fnInit();
	}
   /*
    * 데이타셋 헤더 설정
    */
   function fnSetHeader(){
      if (ds1.countrow < 1){
         var s_temp1 = "M_BLOCK_SID:INT,BLOCK_NO:STRING,GOODS_SID:INT,GOODS_CD:STRING,GOODS_NM:STRING,DEPART_DATE:STRING,GROUP_NM:STRING,REMARKS:STRING,CLIENT_SID:INT,I_DATE:STRING";
         ds1.SetDataHeader(s_temp1);
      }
      if (ds2.countrow < 1){
         var s_temp2 = "M_BLOCK_SID:INT,BLOCK_SID:INT,A_ROOM_TYPE_SID:INT,ROOM_TYPE_CD:STRING,ROOM_TYPE_NM:STRING,UPJANG_NM:STRING,A_ROOM_CNT:INT,ACCEPT_PERSONS:INT,A_REMARKS:STRING,BLOCK_STATUS_CD:STRING,STD_PERSONS:INT";
         ds2.SetDataHeader(s_temp2);
      }
   }
   /*
    * 선조회
    */
   function fnInit(){
      sBgnDate.text='<%=firstday%>';
      sEndDate.text='<%=lastday%>';

        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        cfStyleGrid(getObjectFirst("gr2"), "comn");
      fnSetHeader();
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        //대리점
        ds6.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cu001H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds6.Reset();
        //객실타입, 블록상태, 상품정보
        ln_TRSetting(tr1,
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm510I",
            "JSP(O:DS3=ds3,O:DS4=ds4,O:DS5=ds5)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
   }
   /*
    * 메인조회
    */
    function fnSelect() {
      if (sBgnDate.text.trim() == '' || sEndDate.text.trim() == '' ) {
         alert("출발일자를 입력하십시오.");
         return;
      }
      if (sClientCd.value == '') {
         alert("대리점을 입력하십시오.");
         return;
      }
      if (ds1.isUpdated || ds2.IsUpdated ) {
         alert("수정중인 행이 있습니다.");
         return;
      }
        div='select';
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        v_job = "S";
        ds2.ClearData();
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sBgnDate=" + sBgnDate.text + ","
            + "sEndDate=" + sEndDate.text + ","
            + "sBlockStatusCd=" + ds4.namevalue(ds4.rowposition,"detail") + ","
            + "sAcceptBgnDate=" + sAcceptBgnDate.text + ","
            + "sAcceptEndDate=" + sAcceptEndDate.text;
            if ( sClientSid.value == '' )
               param += ",sClientSid=0";
            else
               param += ",sClientSid="+sClientSid.value;
        ln_TRSetting(tr1,
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm510I",
            "JSP(O:DEFAULT=ds1)",
            param);
        tr_post(tr1);
    }
   /*
    * 디테일조회
    */
    function fnSelectDS2() {
      if ( ds1.isUpdated || ds2.IsUpdated ) {
         alert("수정중인 행이 있습니다.");
      } else {
           window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
           v_job = "S";
           var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
               + "sMBlockSid=" + ds1.namevalue(ds1.rowposition,"m_block_sid");
           ln_TRSetting(tr1,
               "<%=dirPath%><%=HDConstant.PATH_RM%>Rm510I",
               "JSP(O:DS2=ds2)",
               param);
           tr_post(tr1);
        }
    }
   /*
    * 행추가(그리드별)
    */
   function fnAddRow1() {
      if ( ds1.isUpdated || ds2.IsUpdated ) {
         alert("수정중인 행이 있습니다.");
         return;
      }
      if ( sClientSid.value == '' || sClientSid.value == 0 ) {
         alert("대리점를 선택해 주세요.");
         return;
      }
      ds2.ClearData();
      ds1.addrow();
      ds1.namevalue(ds1.rowposition,"client_sid") = sClientSid.value;
   }
   /*
    * 행추가(그리드별)
    */
   function fnAddRow2() {
      if ( ds1.CountRow > 0 ) {
         ds2.addrow();
         ds2.namevalue(ds2.rowposition,"m_block_sid") = ds1.namevalue(ds1.rowposition,"m_block_sid");
         ds2.namevalue(ds2.rowposition,"std_persons") = 0;
         ds2.namevalue(ds2.rowposition,"block_status_cd") = 'RQ';
         if ( ds1.namevalue(ds1.rowposition,"goods_cd") == '1111203' ) {
            ds2.namevalue(ds2.rowposition,"room_type_cd") = '1DBZO';
            //객실타입명 setting
              var flag = false;
                  for(var i=1; i<=ds3.CountRow; i++){
                      if(ds3.NameValue(i, "room_type_cd")==ds2.NameValue(ds2.rowposition, "room_type_cd")){
                          ds2.NameValue(ds2.rowposition, "a_room_type_sid") = ds3.NameValue(i, "room_type_sid");
                          ds2.NameValue(ds2.rowposition, "room_type_nm") = ds3.NameValue(i, "room_type_nm");
                          ds2.NameValue(ds2.rowposition, "upjang_sid") = ds3.NameValue(i, "upjang_sid");
                          ds2.NameValue(ds2.rowposition, "upjang_nm") = ds3.NameValue(i, "upjang_nm");
                          ds2.NameValue(ds2.rowposition, "std_persons") = ds3.NameValue(i, "std_persons");
                         flag = true;
                          return;
                      }
                  }
                  if(!flag) {
                      ds2.NameValue(ds2.rowposition, "a_room_type_sid") = 0;
                      ds2.NameValue(ds2.rowposition, "room_type_nm") = "";
                       ds2.NameValue(ds2.rowposition, "upjang_sid") = 0;
                       ds2.NameValue(ds2.rowposition, "upjang_nm") = "";
                       ds2.NameValue(ds2.rowposition, "std_persons") = 0;
                   }
         }
      }
   }
   /*
    * 마스터 삭제(그리드별)
    */
   function fnDeleteRow1() {
      if (ds2.IsUpdated )
         alert("수정중인 행이 있습니다.");
      else {
         if (ds2.CountRow > 0) {
            for ( i=1;i<=ds2.CountRow;i++ )  {
               if(ds2.namevalue(i, "block_status_cd") !='RQ' ) {
                  alert("신청블록 이외의 블록이 있습니다. 마스터를 삭제 할 수 없습니다.");
                  return;
               }
            }
         }
         ds1.DeleteRow(ds1.RowPosition);
      }
   }
   /*
    * 행삭제(그리드별)
    */
   function fnDeleteRow2() {
      if ( ds2.CountRow > 0 ) {
         if(ds2.namevalue(ds2.rowposition,"block_status_cd") !='RQ' )
            alert("신청블록만 삭제할 수 있습니다.");
         else
            ds2.deleterow(ds2.rowposition);
      }
   }
   /*
    * 적용
    */
   function fnApply() {
      if ( ds1.isUpdated || ds2.isUpdated ) {
         if ( ds1.isUpdated ) {
            for ( i=1;i<=ds1.CountRow;i++ )  {
               if ( ds1.RowStatus(i) == 1 || ds1.RowStatus(i) == 3 ) {  // 입력/변경
                  if ( ds1.namevalue(i,"goods_sid") == '' || ds1.namevalue(i,"goods_sid") == 0 ) {
                     alert("상품을 입력해 주세요.");
                     return;
                  }
                  if ( ds1.namevalue(i,"depart_date") == '' ) {
                     alert("출발일자를 입력해 주세요..");
                     return;
                  }
                  for (j=1;j<=ds2.CountRow;j++) {
                     if (ds2.NameValue(j, "block_status_cd") !='RQ' ) {
                        if (ds1.OrgNameValue(i, "goods_cd") != ds1.NameValue(i, "goods_cd")) {
                           alert("신청블록 이외의 블록이 있습니다. 상품코드를 변경할 수 없습니다.");
                           return;
                        }
                        if (ds1.OrgNameValue(i, "depart_date") != ds1.NameValue(i, "depart_date")) {
                           alert("신청블록 이외의 블록이 있습니다. 출발일자를 변경할 수 없습니다.");
                           return;
                        }
                     }
                  }

               }
            }
         }
         if ( ds2.isUpdated ) {
            for ( j=1;j<=ds2.CountRow;j++ )  {
               if ( ds2.RowStatus(j) == 1 || ds2.RowStatus(j) == 3 ) {
                  if ( ds2.namevalue(j,"a_room_type_sid") == '' || ds2.namevalue(j,"a_room_type_sid") == 0 ) {
                     alert("객실타입을 입력하십시오.");
                     return;
                  }
               }
            }
         }
            v_job = "I";
            window.status="저장 중입니다. 잠시만 기다려 주십시오...";
            ln_TRSetting(tr1,
                "<%=dirPath%><%=HDConstant.PATH_RM%>Rm510I",
                "JSP(I:DEFAULT=ds1,I:DS2=ds2,O:blockNoDS=blockNoDS,O:blockSidDS=blockSidDS,O:msgDS=msgDS)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
            tr_post(tr1);
         }
   }
   /*
    * 취소
    */
   function fnCancel() {
      if (ds1.IsUpdated ) {
         ds1.undoall();
         window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
      }
      if (ds2.IsUpdated ) {
         ds2.undoall();
         window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
      }
   }
   /*
    * 대리점팝업
    */
   function fnPopup() {
         var arrParam   = new Array();
         var arrResult  = new Array();
         var strURL;
         var strPos;
         strURL = "<%=dirPath%>/Sales/help/cu001h.jsp";
         strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

         arrResult = showModalDialog(strURL,arrParam,strPos);

         if (arrResult != null) {
            arrParam = arrResult.split(";");
            sClientSid.value = arrParam[0];
            sClientCd.value = arrParam[2];
            sClientNm.value = arrParam[1];
         } else {
            sClientSid.value = 0;
            sClientCd.value = '';
            sClientNm.value = '';
         }
   }
   /*
    * 대리점 자동셋팅(조건)
    */
   function fnSetting(dataSet) {
      var exit=false;
      if ( dataSet == 'ds6' ) {  //대리점
         for ( i=1; i<=ds6.CountRow; i++ ) {
            if ( ds6.namevalue(i,"client_cd") == sClientCd.value ) {
               sClientSid.value = ds6.namevalue(i,"client_sid");
               sClientNm.value = ds6.namevalue(i,"client_nm");
               exit=true;
               return;
            }
         }
         if ( exit != true ) {
            sClientSid.value = 0;
            sClientNm.value = '';
         }
      }
   }
   /*
    * 객실타입셋팅
    */
   function fnRoomTypeSidSet() {
      if (ds1.IsUpdated ) {
         ds1.undoall();
         window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
      }
      if (ds2.IsUpdated ) {
         ds2.undoall();
         window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
      }
   }
    </script>

<%
/*=============================================================================
         Gauce Components Event Scripts
=============================================================================*/
%>

      <script language=JavaScript for=gr1 event=OnClick(Row,Colid)>
         if ( ds1.isUpdated || ds2.IsUpdated ) {
         } else {
            fnSelectDS2();
      }
      </script>

       <script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
           if(colid=="goods_cd") {
               var arrParam    = new Array();
               var arrResult   = new Array();
               var strURL;
               var strPos;

               arrParam[0] = "RM002";
               arrParam[1] = "업장타입"; //공통코드의 마스터값
               strURL = "<%=dirPath%>/Sales/help/rm002h.jsp";
               strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
               arrResult = showModalDialog(strURL,arrParam,strPos);
               if (arrResult != undefined) {
                   arrParam = arrResult.split(";");
                   ds1.namevalue(ds1.RowPosition,"goods_sid")=arrParam[0];
                   ds1.namevalue(ds1.RowPosition,"goods_cd")=arrParam[1];
                   ds1.namevalue(ds1.RowPosition,"goods_nm")=arrParam[2];
               }
           }
       </script>

      <script language=JavaScript for=gr1 event=OnExit(row,colid,olddata)>
           var flag = false;
           if(colid=='goods_cd'){
               for(var i=1; i<=ds5.CountRow; i++){
                   if(ds5.NameValue(i, "goods_cd")==ds1.NameValue(row, colid)) {
                       ds1.NameValue(row, "goods_sid") = ds5.NameValue(i, "goods_sid");
                       ds1.NameValue(row, "goods_nm") = ds5.NameValue(i, "goods_nm");
                      flag = true;
                       return;
                   }
               }
               if(!flag) {
                   ds1.NameValue(row, "goods_sid") = "";
                   ds1.NameValue(row, "goods_nm") = "";
                }
           }
      </script>

      <script language=JavaScript for=gr1 event=OnKeyPress(kcode)>
         if ( kcode == 40 || kcode == 38 ) {
            if ( ds1.isUpdated || ds2.IsUpdated ) {
            } else
                  fnSelectDS2();
         }
      </script>

       <script language=JavaScript for=gr2 event=OnPopup(row,colid,data)>
           if(colid=="room_type_cd") {
               var arrParam    = new Array();
               var arrResult   = new Array();
               var strURL;
               var strPos;

               strURL = "<%=dirPath%>/Sales/help/rm001h.jsp";
               strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
               arrResult = showModalDialog(strURL,arrParam,strPos);
               if (arrResult != undefined) {
                   arrParam = arrResult.split(";");
                   ds2.namevalue(ds2.RowPosition,"a_room_type_sid")=arrParam[0];
                   ds2.namevalue(ds2.RowPosition,"room_type_cd")=arrParam[1];
                   ds2.namevalue(ds2.RowPosition,"room_type_nm")=arrParam[2];
                   ds2.namevalue(ds2.RowPosition,"upjang_sid")=arrParam[3];
                   ds2.namevalue(ds2.RowPosition,"upjang_nm")=arrParam[4];
                   ds2.namevalue(ds2.RowPosition,"std_persons")=arrParam[5];
               } else {
                   ds2.namevalue(ds2.RowPosition,"a_room_type_sid")=0;
                   ds2.namevalue(ds2.RowPosition,"room_type_cd")='';
                   ds2.namevalue(ds2.RowPosition,"room_type_nm")='';
                   ds2.namevalue(ds2.RowPosition,"upjang_sid")=0;
                   ds2.namevalue(ds2.RowPosition,"upjang_nm")='';
                   ds2.namevalue(ds2.RowPosition,"std_persons")=0;
               }
            //인원 = 표준인원 * 객실수
               ds2.namevalue(ds2.RowPosition,"accept_persons") = ds2.namevalue(ds2.RowPosition,"std_persons") * ds2.namevalue(ds2.RowPosition,"a_room_cnt");
           }
       </script>

      <script language=JavaScript for=gr2 event=OnExit(row,colid,olddata)>
         if ( colid == 'a_room_cnt' ) {
            //인원 = 표준인원 * 객실수
            if ( ds2.namevalue(ds2.RowPosition,"a_room_cnt") != olddata )
                 ds2.namevalue(ds2.RowPosition,"accept_persons") = ds2.namevalue(ds2.RowPosition,"std_persons") * ds2.namevalue(ds2.RowPosition,"a_room_cnt");
         }
         //객실타입명 setting
           var flag = false;
           if(colid=='room_type_cd'){
               for(var i=1; i<=ds3.CountRow; i++){
                   if(ds3.NameValue(i, "room_type_cd")==ds2.NameValue(row, colid)){
                       ds2.NameValue(row, "a_room_type_sid")   = ds3.NameValue(i, "room_type_sid");
                       ds2.NameValue(row, "room_type_nm")      = ds3.NameValue(i, "room_type_nm");
                       ds2.NameValue(row, "upjang_sid")        = ds3.NameValue(i, "upjang_sid");
                       ds2.NameValue(row, "upjang_nm")         = ds3.NameValue(i, "upjang_nm");
                       ds2.NameValue(row, "std_persons")       = ds3.NameValue(i, "std_persons");
                      flag = true;
                       return;
                   }
               }
               if(!flag) {
                   ds2.NameValue(row, "a_room_type_sid") = 0;
                   ds2.NameValue(row, "room_type_nm")    = "";
                   ds2.NameValue(row, "upjang_sid")      = ""
                   ds2.NameValue(row, "upjang_nm")       = ""
                   ds2.NameValue(row, "std_persons")     = 0;
                }
            //인원 = 표준인원 * 객실수
              ds2.namevalue(ds2.RowPosition,"accept_persons") = ds2.namevalue(ds2.RowPosition,"std_persons") * ds2.namevalue(ds2.RowPosition,"a_room_cnt");
           }
      </script>

      <script language="javascript"  for=gr2 event=OnColumnPosChanged(row,colid)>
         if ( ds2.RowStatus(row) == 0) {
            if(ds2.namevalue(row,"block_status_cd") != 'RQ' ){
               gr2.ColumnProp('room_type_cd',   'Edit') = 'None';
               gr2.ColumnProp('a_room_cnt',     'Edit') = 'None';
               gr2.ColumnProp('accept_persons', 'Edit') = 'None';
               gr2.ColumnProp('a_remarks',      'Edit') = 'None';
            }  else {
               gr2.ColumnProp('room_type_cd',   'Edit') = 'Upper';
               gr2.ColumnProp('a_room_cnt',     'Edit') = '';
               gr2.ColumnProp('accept_persons', 'Edit') = '';
               gr2.ColumnProp('a_remarks',      'Edit') = '';
            }
         } else {
            gr2.ColumnProp('room_type_cd',   'Edit') = 'Upper';
            gr2.ColumnProp('a_room_cnt',     'Edit') = '';
            gr2.ColumnProp('accept_persons', 'Edit') = '';
            gr2.ColumnProp('a_remarks',      'Edit') = '';
         }
      </script>

       <script language=JavaScript for=sBgnDate event=OnKillFocus()>
           if( sBgnDate.Modified == true )
            sEndDate.text = sBgnDate.text;
       </script>

       <script language=JavaScript for=sAcceptBgnDate event=OnKillFocus()>
           if( sAcceptBgnDate.Modified == true )
            sAcceptEndDate.text = sAcceptBgnDate.text;
       </script>

<%
/*=============================================================================
         Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  작업성공
%>
   <script language="javascript" for="tr1" event="onsuccess()">
      var msg='';
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
            ds1.namevalue(ds1.rowposition,"m_block_sid") = blockNoDS.namevalue(1,"m_block_sid");
            ds1.namevalue(ds1.rowposition,"block_no") = blockNoDS.namevalue(1,"block_no");
            ds1.namevalue(ds1.rowposition,"i_date") = blockNoDS.namevalue(1,"i_date");
            ds1.ResetStatus();
            var count=1;
            for ( i=1;i<=ds2.CountRow;i++ ) {
            if ( ds2.namevalue(i,"block_sid") == "0" ) {
                  ds2.namevalue(i,"block_sid") = blockSidDS.namevalue(count,"block_sid");
                  ds2.namevalue(i,"m_block_sid") = blockSidDS.namevalue(count,"m_block_sid");
                  count++;
               }
            }
            ds2.ResetStatus();
            for ( i=1; i<=msgDS.CountRow; i++ ) {
               msg+=msgDS.namevalue(i,"pMsg")+"\n";
            }
            if (msgDS.CountRow > 0) {
               alert(msg);
               msgDS.ClearData();
            }
        }  else if(v_job == "H" || v_job=="S") {
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
         }
   </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  작업실패
%>
   <script language="javascript" for="tr1" event="onfail()">
      if(v_job=="I") {
         window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
      }  else if(v_job == "H" || v_job=="S")
         window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";

      var alertMsg = '';
      var nErrCnt = tr1.SrvErrCount("ERROR");

      for (i = 0; i < nErrCnt; i++)
         alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";

      if ( nErrCnt > 0 )
         alert(alertMsg);

      var msg='';
      //메시지 처리
      for ( j=1; j<=msgDS.CountRow; j++ )
         msg+=msgDS.namevalue(j,"pMsg")+"\n";

      if (msgDS.CountRow > 0) {
         alert(msg);
         msgDS.ClearData();
      }
   </script>
<%
/*=============================================================================
         DataSet Component's Event Message Scripts
=============================================================================*/
%>
   <script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
       fnOnProgressEnd();
        div='';
        totalNum.value=ds1.CountRow;
        if ( ds1.CountRow > 0 ) {
         fnSelectDS2();
      }
   </script>

   <script language=JavaScript  for=ds1 event="OnLoadStarted()">
      window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
   </script>

   <script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
       fnOnProgressEnd();
        div='';
   </script>

<%
/*=============================================================================
         DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<!-- 객실타입 -->
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=blockNoDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=blockSidDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<!-- 메시지  -->
<object id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<table border="0" cellpadding="0" cellspacing="0" width="100%">
   <tr>
      <td>
         <table border="0" width="845px"  cellpadding="0" cellspacing="0">
            <tr>
               <td align="left" >
                  <table width="845px" border="0"  cellspacing="0" cellpadding="0" >
                     <tr>
                        <td align="right">
                           <table border="0"  cellpadding="0" cellspacing="0" width="100%">
                              <tr>
                                 <td align="right" height="30px">
                                    <img src="<%=dirPath%>/Sales/images/refer.gif"     style="cursor:hand" onclick="fnSelect()">
                                    <img src="<%=dirPath%>/Sales/images/new.gif" style="cursor:hand" onClick="fnAddRow1()" >
                                    <img src="<%=dirPath%>/Sales/images/save.gif"      style="cursor:hand" onClick="fnApply();">
                                    <img src="<%=dirPath%>/Sales/images/cancel.gif" style="cursor:hand"  onclick="fnCancel()">
                                    <img src="<%=dirPath%>/Sales/images/delete.gif"  style="cursor:hand" onClick="fnDeleteRow1()" >
                                 </td>
                              </tr>
                           </table>
                        </td>
                     </tr>
                  </table>
               </td>
            </tr>
            <tr>
               <td align="left" >
                  <table width="845px" border="0"  cellspacing="0" cellpadding="0" >
                     <tr>
                        <td  width="845px">
							<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
							  <tr bgcolor="#6f7f8d" height=30>
								<td align=left width=70 class="text">&nbsp;<b>출발일자</b></td>
								<td align=left bgcolor="#ffffff" valign="middle">&nbsp;
                                   <comment id="__NSID__"><object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
                                    <param name=Text     value="">
                                    <param name=Alignment   value=1>
                                    <param name=Format      value="0000-00-00">
                                    <param name=Cursor      value="iBeam">
                                    <param name=Border      value="0">
                                    <param name=InheritColor      value="true">
                                    <param name=ReadOnly    value="false">
                                    <param name=SelectAll   value="true">
                                    <param name=SelectAllOnClick   value="true">
                                    <param name=SelectAllOnClickAny     value="false">
                                   </object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>&nbsp;-
                                   <comment id="__NSID__"><object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
                                    <param name=Text     value="">
                                    <param name=Alignment   value=1>
                                    <param name=Format      value="0000-00-00">
                                    <param name=Cursor      value="iBeam">
                                    <param name=Border      value="0">
                                    <param name=InheritColor      value="true">
                                    <param name=ReadOnly    value="false">
                                    <param name=SelectAll   value="true">
                                    <param name=SelectAllOnClick   value="true">
                                    <param name=SelectAllOnClickAny     value="false">
                                   </object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
								</td>
								<td align=left width=70 class="text">&nbsp;블럭상태</td>
                                <td align=left bgcolor="#ffffff">&nbsp;
                                       <%=HDConstant.COMMENT_START%>
                                           <object id=sBlockStatusCd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                       <param name=ComboDataID    value=ds4>
                                       <param name=BindColumn      value="detail">
                                                     <param name=BindColVal      value="detail">
                                       <param name=EditExprFormat value="%,%;detail,detail_nm">
                                       <param name=ListExprFormat  value="detail_nm^0^50"></object>
                                    <%=HDConstant.COMMENT_END%>
								</td>
								<td align=left width=70 class="text">&nbsp;대리점</td>
								<td align=left bgcolor="#ffffff">&nbsp;
                                    <input id="sClientSid" type="hidden" value="0">
                                    <input id="sClientCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:40px; height:20px;" maxlength="5" onBlur="fnSetting('ds6')">
                                    <img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="대리점를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup();">
                                    <input id="sClientNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;" maxlength="50" onBlur="" readOnly>
								</td>
							  </tr>
							  <tr bgcolor="#6f7f8d" height=30>
								<td align=left width=70 class="text">&nbsp;신청일자</td>
								<td align=left bgcolor="#ffffff" valign="middle" colspan="8">&nbsp;
                                   <comment id="__NSID__"><object id=sAcceptBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
                                    <param name=Text     value="">
                                    <param name=Alignment   value=1>
                                    <param name=Format      value="0000-00-00">
                                    <param name=Cursor      value="iBeam">
                                    <param name=Border      value="0">
                                    <param name=InheritColor      value="true">
                                    <param name=ReadOnly    value="false">
                                    <param name=SelectAll   value="true">
                                    <param name=SelectAllOnClick   value="true">
                                    <param name=SelectAllOnClickAny     value="false">
                                 </object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>&nbsp;-
                                   <comment id="__NSID__"><object id=sAcceptEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
                                    <param name=Text     value="">
                                    <param name=Alignment   value=1>
                                    <param name=Format      value="0000-00-00">
                                    <param name=Cursor      value="iBeam">
                                    <param name=Border      value="0">
                                    <param name=InheritColor      value="true">
                                    <param name=ReadOnly    value="false">
                                    <param name=SelectAll   value="true">
                                    <param name=SelectAllOnClick   value="true">
                                    <param name=SelectAllOnClickAny     value="false">
                                 </object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
								</td>
							  </tr>
							</table>
                        </td>
                     </tr>
                  </table>
               </td>
            </tr>
            <tr height="10">
               <td></td>
            </tr>
            <tr>
               <td width="845px">
                  <table  border="0" cellpadding="0" cellspacing="0">
                     <tr valign="top"">
                        <td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
                           <%=HDConstant.COMMENT_START%>
                           <object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:150" border="1" >
                                    <param name="DataID"    VALUE="ds1">
                                    <param name="BorderStyle"   VALUE="0">
                                    <param name=ColSizing       value="true">
                                    <param name="editable"      value="true">
                                    <param name=UsingOneClick     value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
                                         <param name="IndWidth"         value=20">
                              <param name="Format"          value="
                                     <C> name='마스터블록SID'     ID='m_block_sid'   HeadAlign=Center Width=80  align=center editlimit=10 show=false </C>
                                     <C> name='블록번호'     ID='block_no'   HeadAlign=Center BgColor=#fefec0 Width=80  align=center editlimit=10 edit=none sort=true show=true mask=XXXXXX-XXXX </C>
                                     <C> name='상품SID'     ID='goods_sid'   HeadAlign=Center Width=80  align=left editlimit=10 show=false</C>
                                     <C> name='상품'     ID='goods_cd'   HeadAlign=Center Width=60  align=center editstyle=popup editlimit=7 show=true</C>
                                     <C> name='상품명'       ID='goods_nm'     HeadAlign=Center BgColor=#fefec0 Width=120  align=left edit=none editlimit=40 sort=true show=true</C>
                                     <C> name='출발일자'       ID='depart_date'     HeadAlign=Center Width=80  align=center editlimit=8 sort=true show=true mask=XXXX-XX-XX</C>
                                     <C> name='단체명'       ID='group_nm'     HeadAlign=Center Width=150  align=left editlimit=30 show=true</C>
                                     <C> name='참고사항'       ID='remarks'     HeadAlign=Center Width=250  align=left editlimit=50 show=true</C>
                                     <C> name='대리점SID'       ID='client_sid'     HeadAlign=Center Width=100  show=false</C>
                                     <C> name='신청일자'       ID='i_date'     HeadAlign=Center BgColor=#fefec0 Width=70 edit=none mask=XXXX-XX-XX</C>
                              ">
                           </object>
                           <%=HDConstant.COMMENT_END%>
                        </td>
                     </tr>
                  </table>
               </td>
            </tr>
            <tr id="total">
               <td width="845px" height="20" class="textbox" style="border:0">
                  총건수 : <input type="text" name="totalNum" style="border:0;align=left" width="20">
               </td>
            </tr>
		</table>
      </td>
   </tr>
   <tr height="30px">
      <td align="left" >
         <table width="845px" border="0"  cellspacing="0" cellpadding="0" >
            <tr>
               <td  width="500px">
               </td>
               <td align="right">
                  <table border="0"  cellpadding="0" cellspacing="0" width="100%">
                     <tr>
                        <td align="right" height="30px">
                           <img src="<%=dirPath%>/Sales/images/plus.gif"   style="cursor:hand" onClick="fnAddRow2()" >
                           <img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="fnDeleteRow2()" >
                        </td>
                     </tr>
                  </table>
               </td>
            </tr>
         </table>
      </td>
   </tr>
   <tr height="10">
      <td></td>
   </tr>
   <tr>
      <td width="845px">
         <table  border="0" cellpadding="0" cellspacing="0">
            <tr valign="top"">
               <td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
                  <%=HDConstant.COMMENT_START%>
                  <object id=gr2 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:150" border="1" >
                           <param name="DataID"    VALUE="ds2">
                           <param name="BorderStyle"   VALUE="0">
                           <param name=ColSizing       value="true">
                           <param name="editable"      value="true">
                           <param name=UsingOneClick     value="1">
                               <Param Name="AllShowEdit"   value="True">
                               <param name="SortView"      value="Right">
                               <param name="ViewSummary"      value="1">

                     <param name="Format" value="
                            <C> name='M블록SID'        ID='m_block_sid'     HeadAlign=Center Width=100  align=center show=false</C>
                            <C> name='블록SID'         ID='block_sid'       HeadAlign=Center Width=100  align=center show=false</C>
                            <C> name='신청객실타입SID' ID='a_room_type_sid' HeadAlign=Center Width=100  align=center show=false</C>
                            <C> name='객실타입'        ID='room_type_cd'    HeadAlign=Center Width=70  align=center edit='Upper' editstyle=popup editlimit=5 sumtext=총건수 sumbgcolor=#E0CFE4 sumcolor=#000000 sort=true show=true</C>
                            <C> name='객실타입명'      ID='room_type_nm'    HeadAlign=Center BgColor=#fefec0 Width=100  align=left edit=none sumbgcolor=#E0CFE4 sort=true editlimit=20 show=true</C>
                            <C> name='영업장명'        ID='upjang_nm'       HeadAlign=Center BgColor=#fefec0 Width=100  align=left edit=none sumbgcolor=#E0CFE4 show=true</C>
                            <C> name='객실수'          ID='a_room_cnt'      HeadAlign=Center Width=50  align=right editlimit=3 sumbgcolor=#E0CFE4 sumcolor=#000000 sumtext=@sum show=true</C>
                            <C> name='인원'            ID='accept_persons'  HeadAlign=Center Width=50  align=right editlimit=3 sumbgcolor=#E0CFE4 sumcolor=#000000 sumtext=@sum show=true</C>
                            <C> name='요청사항'        ID='a_remarks'       HeadAlign=Center Width=250  align=left editlimit=50 show=true edit={IF(block_status_cd='RQ','false','none')} sumbgcolor=#E0CFE4</C>
                            <C> name='블럭상태'        ID='block_status_cd' HeadAlign=Center BgColor=#fefec0 Width=80  align=center edit=none editlimit=2 editstyle=lookup data='ds4:detail:detail' sumbgcolor=#E0CFE4 show=true</C>
                            <C> name='표준인원'        ID='std_persons'     HeadAlign=Center BgColor=#fefec0 Width=80  align=center edit=none editlimit=2 show=false</C>
                     ">
                  </object>
                  <%=HDConstant.COMMENT_END%>
               </td>
            </tr>
         </table>
      </td>
   </tr>
</table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

