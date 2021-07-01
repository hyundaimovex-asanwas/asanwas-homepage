<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<%@ page import="java.util.Date"%>
<% String dirPath = request.getContextPath(); //HDASan. ContextPath 및 기타 변수 설정. %>

<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	통화 관리
+ 프로그램 ID	: bm052i.jsp
+ 기 능 정 의	: 조회|수정|저장
+ 서 블 릿 명	: bm052i_s01,bm052i_s02,bm052i_s03,bm052i_t01,bm052i_chk_s01
------------------------------------------------------------------------------>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<jsp:include page="/Sales/common/include/head.jsp"/>
<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
	get_cookdata();
	var gs_date = gn_Replace(gcurdate,"/");

	/******************************************************************************
		Description : 페이지 로딩
	******************************************************************************/
	function fnOnLoad(tree_idx){	
		fnInit_tree(tree_idx);	
		ln_Before(); 
	}

	/******************************************************************************
		Description : 선조회
	******************************************************************************/
	function ln_Before(){
		gcds_cm002.DataID = "/services/servlet/sales.bm.bm056i_s01?v_str2=S&v_str3=TOP";
		gcds_cm002.Reset();
		gcem_11.text = gcds_cm002.NameValue(1,"TH_UNIT");
		gcds_cm002.DataID = "/services/servlet/sales.bm.bm056i_s01?v_str2=N&v_str3=TOP";
		gcds_cm002.Reset();
		gcem_12.text = gcds_cm002.NameValue(1,"TH_UNIT");
	}

	/******************************************************************************
		Description : 조회(상위)
	******************************************************************************/
	function ln_Query1(){
		var sdata = "/services/servlet/sales.bm.bm052i_s01"
							+ "?v_str1=" + txt_custnm_fr.value;//성명
		gcds_data_1.DataID = sdata; 
		gcds_data_1.Reset();			
	}

	/******************************************************************************
		Description : 조회(하위)
	******************************************************************************/
	function ln_Query2(){
		var temp= gcem_telNum.text;
		var chk="";

		temp = temp.replace("-","");
		temp = temp.replace("-","");

		for (i=0;i<temp.length;i++){
			if(temp.charAt(i)>="0" && temp.charAt(i)<="9"){
				chk="N";
			}else{
				chk="C";
				break;
			}
		}

		if(chk=="N"){
			//alert("숫자");
			var str1 = temp;

			var sdata = "/services/servlet/sales.bm.bm052i_s02"
								+ "?v_str1=" + str1;//숫자(전화번호)
			gcds_data_2.DataID = sdata; 
			gcds_data_2.Reset();			
		}else{
      //alert("문자");
			var str2 = temp;
			var sdata = "/services/servlet/sales.bm.bm052i_s02"
								+ "?v_str2=" + str2;//문자(수신처)
			gcds_data_2.DataID = sdata; 
			gcds_data_2.Reset();
		}	

	}

	/******************************************************************************
		Description : 사원(팝업)
	******************************************************************************/
	function ln_SrhEmpno(){
		var strURL = "bm051i_r.html";
		var strPos = "dialogWidth:435px;dialogHeight:475px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");

		txt_cust_sid.value   = firstList[0];
		txt_work_no.value   = firstList[0];
		txt_rec_plac.value  = firstList[1];
		txt_vend_nm.value  = firstList[2];
		gcra_ct.CodeValue = "c";
		txt_work_no.disabled=true;
	} 

	/******************************************************************************
		Description : 등록
	******************************************************************************/
	function ln_Add(){ 

		if (gcds_data_3.RowStatus(gcds_data_3.RowPosition) == 1 ){
					return false;
		}
		ln_Enable("s");

		now = new Date(); // 현재시간 가져오기
		hour = now.getHours(); // 시간 가져오기
		if(hour < 10){hour = "0" + hour;}
		min = now.getMinutes(); // 분 가져오기
		if(min < 10){min = "0" + min;}
		sec = now.getSeconds(); // 초 가져오기
		if(sec < 10){sec = "0" + sec;}


		gcds_data_3.addrow();
		var row = gcds_data_2.rowposition;
		if (row<1) return;

//		gcds_data_3.NameValue(gcds_data_3.rowposition,"CUST_SID") = gcds_data_2.NameValue(gcds_data_2.rowposition,"CUST_SID");//사업자번호1
//		gcds_data_3.NameValue(gcds_data_3.rowposition,"CT") = "c";                                                            //사업구분2
//		gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_SID") = gcds_data_2.NameValue(gcds_data_2.rowposition,"TEL_SID");  //4.전화번호TEL_SID
		gcem_tel_date.text = gs_date;                                                                                         //5.통화일자
		gcem_tel_stime.text = hour + "" + min + "" + sec; 
		gcem_tel_etime.text = hour + "" + min + "" + sec; 
//		gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_STIME") = hour + "" + min + "" + sec;            //6.통화시작시간
//		gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_ETIME") = hour + "" + min + "" + sec;            //7.통화종료시간
//		gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_DURA") = "0";            //8.사용시간.(물어볼것)
																																	//9.요금(물어볼것)
//		gcds_data_3.NameValue(gcds_data_3.rowposition,"CAL_YN") = "N";                                                        //10.정산여부 
//		gcds_data_3.NameValue(gcds_data_3.rowposition,"I_EMPNO") = gusrid;                                                    //11.입력자 
//		gcds_data_3.NameValue(gcds_data_3.rowposition,"U_EMPNO") = gusrid;                                                    //12.수정자 
		gcra_cal_yn.CodeValue = "N";			//미정산으로 시작
	}


	/******************************************************************************
		Description : 저장
	******************************************************************************/
	function ln_Save(){
		if (!gcds_data_3.isUpdated) {
			alert(gn_Msg(4));
			return;
		}

		if (!ln_Valchk()) return;

		if(gcra_ct.CodeValue=="t"){	txt_cust_sid.value = "0";	}	//관광객일 경우 사업자번호 없음
		if(txt_tel_sid.value==""){	txt_tel_sid.value = "0";	}	//관광객일 경우 사업자번호 없음

		gcds_data_3.NameValue(gcds_data_3.rowposition,"CUST_SID")		= fn_trim(txt_cust_sid.value);
		gcds_data_3.NameValue(gcds_data_3.rowposition,"CT")				= gcra_ct.CodeValue;
		gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_SID")		= fn_trim(txt_tel_sid.value);
		gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_NUM")		= fn_trim(txt_tel_num.value);
		gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_DATE")		= fn_trim(gcem_tel_date.text);
		gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_STIME")	= fn_trim(gcem_tel_stime.text);
		gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_ETIME")	= fn_trim(gcem_tel_etime.text);
		gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_DURA")		= fn_trim(gcem_tel_dura.text);
		gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_FEE")		= fn_trim(gcem_tel_fee.text);
		gcds_data_3.NameValue(gcds_data_3.rowposition,"CAL_YN")			= gcra_cal_yn.CodeValue;
		gcds_data_3.NameValue(gcds_data_3.rowposition,"WORK_NO")		= fn_trim(txt_work_no.value);
		gcds_data_3.NameValue(gcds_data_3.rowposition,"OP")				= gcra_op.CodeValue;
		gcds_data_3.NameValue(gcds_data_3.rowposition,"I_EMPNO")		= fn_trim(gusrid);
		gcds_data_3.NameValue(gcds_data_3.rowposition,"U_EMPNO")		= fn_trim(gusrid);


		gctr_data.KeyValue = "bm052i_t01(I:DATA=gcds_data_3)";
		gctr_data.Action = "/services/servlet/sales.bm.bm052i_t01";
		//prompt("",gcds_data_3.text);
		gctr_data.post();

		ln_Query2();

	}

	/******************************************************************************
		Description : 입력값 체크
	******************************************************************************/
	function ln_Valchk(){
    if(gcra_ct.CodeValue=="t" && txt_work_no.value=="N"){
		   alert("관광증번호를 입력해 주세요.");
			 return false;
		}
    if(gcra_ct.CodeValue=="t" && gcra_cal_yn.CodeValue=="N"){
		   alert("관광객의 경우 선 정산이 되어야 합니다.");
			 return false;
		}

	if(txt_work_no.value ==""){	alert("실제 통화자를 입력해 주세요.");	return false;}
	if(txt_tel_num.value ==""){	alert("전화번호를 입력해 주세요.");	return false;}
	if(gcem_tel_date.text ==""){alert("통화일자를 입력해 주세요.");	return false;}
	if(gcem_tel_stime.text ==""){alert("통화시작시간을 입력해 주세요.");	return false;}
	if(gcem_tel_etime.text ==""){alert("통화종료시간을 입력해 주세요.");	return false;}
	if(gcem_tel_dura.text ==""){alert("사용시간을 입력해 주세요.");	return false;}
	if(gcem_tel_fee.text ==""){alert("통화금액을 입력해 주세요.");	return false;}

    if(gcra_ct.CodeValue!="t" && gcra_ct.CodeValue!="c"){
		   alert("사업구분을 입력해 주세요.");
			 return false;
		}
    if(gcra_op.CodeValue!="O" && gcra_op.CodeValue!="P"){
		   alert("업무구분을 입력해 주세요.");
			 return false;
		}
    if(gcra_cal_yn.CodeValue!="Y" && gcra_cal_yn.CodeValue!="N"){
		   alert("정산여부를 입력해 주세요.");
			 return false;
		}
/*
		//키값중복체크
		var row = gcds_data_3.rowposition;
		if(gcds_data_3.sysStatus(row)=="1"){
				gcds_chk.DataID = "/services/servlet/sales.bm.bm052i_chk_s01?v_str1="+txt_cust_sid.text;
				gcds_chk.Reset();
				if(gcds_chk.namevalue(1,"CUST_SID") > 0){
					alert("중복된 사업자번호가 있습니다.확인후 입력하세요");
					gcds_data_3.namevalue(row,"CUST_SID") = "";
					gcds_data_3.deleterow(row);
					return;
				}				
		}
*/
		return true;

	}
	
	/******************************************************************************
		Description : Enable Format
	******************************************************************************/
	function ln_Enable(chk){
		if (chk == "a") {
			gcem_tel_date.enable=false;
			gcem_tel_stime.enable=false;
			gcem_tel_etime.enable=false;
			gcem_tel_dura.enable=false;
			gcra_cal_yn.enable=false;
		}else if(chk == "s") {
			gcem_tel_date.enable=true;
			gcem_tel_stime.enable=true;
			gcem_tel_etime.enable=true;
			gcem_tel_dura.enable=true;
			gcra_cal_yn.enable=true;
		}
	}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data_3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data_4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_cm002 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data_1" event="OnLoadStarted()">
	gn_LoadStart();
</script>

<script language="javascript" for="gcds_data_1" event="onloadCompleted(row,colid)">
	gn_LoadComp('1',gcds_data_1.countrow);
</script>

<script language="javascript" for="gcds_data_2" event="OnLoadStarted()">
	gn_LoadStart();
</script>

<script language="javascript" for="gcds_data_2" event="onloadCompleted(row,colid)">
	gn_LoadComp('2',gcds_data_2.countrow);
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript"  for=gcgd_disp1 event=OnClick(Row,Colid)>
	if(gcds_data_1.countrow < 1) {
		txt_cust_sid.text = "";
		txt_vend_nm.value = "";
		txt_rec_plac.value = "";
		return;
	}
//	txt_cust_sid.text = gcds_data_1.namevalue(Row,"CUST_SID");
//	txt_vend_nm.value = gcds_data_1.namevalue(Row,"VEND_NM");
//	txt_work_no.value = gcds_data_1.namevalue(Row,"WORK_NO");
//	txt_rec_plac.value = gcds_data_1.namevalue(Row,"CUST_NM");
//	gcra_ct.CodeValue="c";
</script>

<script language="javascript"  for=gcgd_disp2 event=OnClick(Row,Colid)>
	var str1 = gcds_data_2.namevalue(gcds_data_2.rowposition,"TEL_SID");
	txt_tel_sid.value = gcds_data_2.namevalue(gcds_data_2.rowposition,"TEL_SID");
	txt_tel_num.value = gcds_data_2.namevalue(gcds_data_2.rowposition,"TEL_NUM");
//	var str2 = fn_trim(txt_cust_sid.text);
//	alert("::" + txt_tel_sid.value + "::");
//	alert("::" + txt_tel_num.value + "::");
	var row = gcds_data_3.rowposition;
	gcds_data_3.DataID = "/services/servlet/sales.bm.bm052i_s03?v_str1="+str1;
//									+ "&v_str2=" + str2;
	gcds_data_3.Reset();

	ln_Enable("a");

</script>

<script language="javascript"  for=gcgd_disp3 event=OnClick(Row,Colid)>
//	var str2 = gcds_data_3.namevalue(gcds_data_3.rowposition,"TELHIS_SID");

//	var row = gcds_data_3.rowposition;
//	gcds_data_3.DataID = "/services/servlet/sales.bm.bm052i_s03?v_str2="+str2;

//	gcds_data_3.Reset();

	txt_cust_sid.value	=	gcds_data_3.NameValue(gcds_data_3.rowposition,"CUST_SID");
	gcra_ct.CodeValue	=	gcds_data_3.NameValue(gcds_data_3.rowposition,"CT");
	txt_tel_sid.value	=	gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_SID");
	txt_tel_num.value	=	gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_NUM");
	gcem_tel_date.text	 =	 gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_DATE");
	gcem_tel_stime.text	=	gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_STIME");
	gcem_tel_etime.text	=	gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_ETIME");
	gcem_tel_dura.text	 =	gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_DURA")	;
//	gcem_tel_fee.text	=	gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_FEE");
	gcra_cal_yn.CodeValue	=	gcds_data_3.NameValue(gcds_data_3.rowposition,"CAL_YN")	;
	txt_work_no.value	=	gcds_data_3.NameValue(gcds_data_3.rowposition,"WORK_NO")	;
	gcra_op.CodeValue	 =	 gcds_data_3.NameValue(gcds_data_3.rowposition,"OP");

//	ln_Enable("s");

</script>


<script language=JavaScript for=gcra_ct event=OnSelChange()>
	if(gcra_ct.CodeValue=="t"){
		txt_work_no.disabled=false;
		txt_work_no.value = "";
		txt_tel_sid.value = "";
		txt_tel_num.disabled = false;
	} else if(gcra_ct.CodeValue=="c"){
		txt_work_no.value   = txt_cust_sid.value;
		txt_work_no.disabled=true;
		txt_tel_num.disabled = true;
		txt_tel_sid.value = gcds_data_2.namevalue(gcds_data_2.rowposition,"TEL_SID");
		txt_tel_num.value = gcds_data_2.namevalue(gcds_data_2.rowposition,"TEL_NUM");
//	alert("::" + txt_tel_sid.value + "::");
//	alert("::" + txt_tel_num.value + "::");
	}
</script>

<!--
<script language=JavaScript for=gcem_tel_dura event=OnKillFocus()>
	var usetime = gcem_tel_dura.text;
	if(gcds_data_2.NameValue(gcds_data_2.rowposition,"SN") == "S"){
		 money = gcem_11.text
	} else {
		money = gcem_12.text
	}
	gcem_tel_fee.text = usetime * money;
</script>
//-->
<script language=JavaScript for=gcem_tel_fee event=onSetFocus()>
	var usetime = gcem_tel_dura.text;
	if(gcds_data_2.NameValue(gcds_data_2.rowposition,"SN") == "S"){
		 money = gcem_11.text
	} else {
		money = gcem_12.text
	}
	gcem_tel_fee.text = usetime * money;
</script>

<script language=JavaScript for=gcem_tel_stime event=onKillFocus()>
	var str3 = gcem_tel_stime.text;
	var vstr3 = str2.substring(0,2) + "." + str2.substring(2,4) + "." + str2.substring(4,6);
	if(str3.substring(0,2) > 23){alert(vstr3 + "\n23시보다 작아야 합니다."); gcem_tel_stime.text = "";  return;}
	if(str3.substring(2,4) > 59){alert(vstr3 + "\n59분보다 작아야 합니다."); gcem_tel_stime.text = "";  return;}
	if(str3.substring(4,6) > 59){alert(vstr3 + "\n59초보다 작아야 합니다."); gcem_tel_stime.text = "";  return;}
</script>

<script language=JavaScript for=gcem_tel_etime event=onKillFocus()>

	var v1 = new Date();

	year = v1.getYear(); // 년도 가져오기
	month = v1.getMonth(); // 월 가져오기
	month = month + 1;	//월은 1월이 0 이다. 그러므로 + 1 해줘야 함...
	if(month < 10){	month = "0" + month;}
	date = v1.getDate(); // 날짜 가져오기
	if(date < 10){	date = "0" + date;}

	var v2 = year + "-" + month + "-" + date;
	var str2 = gcem_tel_etime.text;
	var vstr2 = str2.substring(0,2) + "." + str2.substring(2,4) + "." + str2.substring(4,6);
	if(str2.substring(0,2) > 23){alert(vstr2 + "\n23시보다 작아야 합니다."); gcem_tel_etime.text = ""; return;}
	if(str2.substring(2,4) > 59){alert(vstr2 + "\n59분보다 작아야 합니다."); gcem_tel_etime.text = "";  return;}
	if(str2.substring(4,6) > 59){alert(vstr2 + "\n59초보다 작아야 합니다."); gcem_tel_etime.text = "";  return;}

	var str3 = gcem_tel_stime.text;
	var vstr3 = str3.substring(0,2) + "." + str3.substring(2,4) + "." + str3.substring(4,6);

	var sdata = "/services/servlet/sales.bm.bm052i_s04"
						+ "?v_str1=" + v2
						+ "&v_str2=" + vstr3
						+ "&v_str3=" + vstr2;
	gcds_data_4.DataID = sdata; 
	gcds_data_4.Reset();

	var minute_diff = fn_trim(gcds_data_4.NameValue(gcds_data_4.rowposition,"MINUTE_DIFF"));
	if(minute_diff < 0){alert("시작시간이 종료시간보다 늦습니다."); minute_diff = 1; return;}
	//alert("::" + minute_diff + "::");
	if(minute_diff == 0){
		gcem_tel_dura.text = 1;
	} else
	{
		gcem_tel_dura.text = minute_diff;
	}
	gcem_tel_fee.focus();

</script>



<script language=JavaScript for=gcem_telNum event=onKeyDown(kcode,scode)>
	if (kcode != 13) return;
	var temp= gcem_telNum.text;
	var chk="";

	temp = temp.replace("-","");
	temp = temp.replace("-","");

	//alert("temp::"+temp);
	//alert(temp.length);
	for (i=0;i<temp.length;i++){
		if(temp.charAt(i)>="0" && temp.charAt(i)<="9"){
			chk="N";
		}else{
			chk="C";
			break;
		}
	}

	if(chk=="N"){
		//alert("숫자");
		var str1 = temp;

		var sdata = "/services/servlet/sales.bm.bm052i_s02"
							+ "?v_str1=" + str1;//숫자(전화번호)
		gcds_data_2.DataID = sdata; 
		gcds_data_2.Reset();			
	}else{
		//alert("문자");
		var str2 = temp;
		var sdata = "/services/servlet/sales.bm.bm052i_s02"
							+ "?v_str2=" + str2;//문자(수신처)
		gcds_data_2.DataID = sdata; 
		gcds_data_2.Reset();
	}
</script>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert(gn_Msg(1));
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert(gn_Msg(2));
  alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>



</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px">
  <tr> 
    <td  align="right" style="padding-top:4px;" colspan=2>
			<img src="/services/Sales/images/plus.gif"	style="cursor:hand;position:relative;top:-5px;" align=absmiddle onClick="ln_Add()">
      <img src="/services/Sales/images/save.gif"	style="cursor:hand;position:relative;top:-5px;" align=absmiddle onClick="ln_Save()">
		</td>
	</tr>
	<tr><td height=3 colspan=2></td></tr> 
  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td valign=top>
<!--					  <table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:453px;'>
						  <tr>
							  <td class="tab_a0101_1">성&nbsp;&nbsp;&nbsp;&nbsp;명</td>
								<td class="tab_b0001"> 
                  <input id="txt_custnm_fr" type="text" class="txt_a01"  style="width:80px;top:-3px;"  onkeydown="if(event.keyCode==13) ln_Query1();" onBlur="bytelength(this,this.value,30);">		
									<img src="/services/Sales/images/refer.gif"		style="cursor:hand;position:relative;left:4px;top:3px;" onclick="ln_Query1()">
								</td>
							</tr>
							<tr><td height=3 colspan=2></td></tr>
						  <tr>
							  <td colspan=2>
 									<comment id="__NSID__"><OBJECT  id=gcgd_disp1 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:440px;height:161px;" viewastext>
										<param name="DataID"				value="gcds_data_1">
										<param name="HeadBorder" 		value="4">
										<param name="HeadLineColor" value="#A4B8C5">
										<param name="LineColor" 		value="#A4B8C5">
										<param name="TitleHeight"		value="22">
										<param name="RowHeight"			value="20">
										<param name="BorderStyle" 	value="0">
										<param name="ColSizing" 		value="1">
										<param name="FillArea" 			value="1">
										<param name="ViewUnbind" 		value="-1">
										<param name="UsingOneClick" value=1>
										<param name="sortview"			value=left>
										<param name="Format"				value="  
											<F> Name='No.'			ID={CURROW} HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center show=false</F>
											<C> Name='CUST_SID'	ID=CUST_SID	HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=center show=false</C> 
											<C> Name='소속회사'	ID=VEND_NM	HeadAlign=Center HeadBgColor=#EEEEEE Width=120	align=left</C> 
											<C> Name='팀명'	  	ID=TEAM_NM	HeadAlign=Center HeadBgColor=#EEEEEE Width=90		align=left</C> 
											<C> Name='실무번호'	ID=WORK_NO	HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center</C> 
											<C> Name='성명'	  	ID=CUST_NM	HeadAlign=Center HeadBgColor=#EEEEEE Width=65		align=center</C> 
											<C> Name='CUST_GU'	ID=CUST_GU HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=center show=false</C> 
											">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
									<fieldset id=ft_div1 style="width:441px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
										<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
									</fieldset>	
								</td>
							</tr>
						</table><br>	//-->
					  <table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:453px;'>
						  <tr>
							  <td class="tab_a0101_1">전화번호<br>수&nbsp;신&nbsp;처</td>
								<td class="tab_b0001"> 
									<fieldset class=field_01 style="width:120px;">
									<comment id="__NSID__"><OBJECT id=gcem_telNum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										class="gcem_01" style="width:115px;">
											<param name=Alignment			value=0>
											<param name=GeneralEdit   value="true">
											<param name=Border	      value=false>
											<param name=PromptChar	  value="">
											<param name=UpperFlag     value=1>
									</OBJECT></comment><script>__ws__(__NSID__);</script>
									</fieldset>								
									<img src="/services/Sales/images/refer.gif"		style="cursor:hand;position:relative;left:4px;top:3px;" onclick="ln_Query2()">
								</td>
							</tr>
							<tr><td height=3 colspan=2></td></tr>
						  <tr>
							  <td colspan=2 align="center">
 									<comment id="__NSID__"><OBJECT  id=gcgd_disp2 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:440px;height:260px;" viewastext>
										<param name="DataID"				value="gcds_data_2">
										<param name="HeadBorder" 		value="4">
										<param name="HeadLineColor" value="#A4B8C5">
										<param name="LineColor" 		value="#A4B8C5">
										<param name="TitleHeight"		value="22">
										<param name="RowHeight"			value="20">
										<param name="BorderStyle" 	value="0">
										<param name="ColSizing" 		value="1">
										<param name="FillArea" 			value="1">
										<param name="ViewUnbind" 		value="-1">
										<param name="UsingOneClick" value=1>
										<param name="sortview"			value=left>
										<param name="Format"				value="  
											<F> Name='No.'				ID={CURROW} 	HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center show=false</F>
											<C> Name='TEL_SID'		ID=TEL_SID			HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=center show=false</C> 
											<C> Name='전화번호'		ID=TEL_NUM			HeadAlign=Center HeadBgColor=#EEEEEE Width=200		align=left</C> 
											<C> Name='수신처'	  	ID=REC_PLAC			HeadAlign=Center HeadBgColor=#EEEEEE Width=200		align=left</C> 
											<C> Name='CUST_SID'	  	ID=CUST_SID			HeadAlign=Center HeadBgColor=#EEEEEE Width=10		align=left show=false</C> 
											<C> Name='SN'	  	ID=SN			HeadAlign=Center HeadBgColor=#EEEEEE Width=200		align=left show=false</C> 
											">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
									<fieldset id=ft_div2 style="width:441px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
										<font id=ft_cnt2 style="position:relative;top:4px;left:8px"></font>
									</fieldset>	
								</td>
							</tr>
						</table>
					</td>
					<td valign=top>
						<table class="tab_b1011" border="0" cellpadding=0 cellspacing=0 style='width:420px;height:310px;font-size:9pt;'>
							<tr>
   							<td class="tab_a0101">실제 통화자</td>
								<td class="tab_b0101">
                  <input id="txt_work_no" type="text" class="txt_a01"  style="width:120px;"> (실무번호)
								</td>
							</tr>
							<tr>
   							<td class="tab_a0101">통화요청자</td>
								<td class="tab_b0101" colspan=3>
					<input id="txt_cust_sid" type="text" style="width:0px;" disabled>
                  <input id="txt_rec_plac" type="text" class="txt_a01"  style="width:60px;position:relative;left:0px;top:-2px;" disabled><img src="/services/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:4px;top:3px;" onclick="ln_SrhEmpno();">
								</td>
							</tr>
							<tr>
   							<td class="tab_a0101">소&nbsp;&nbsp;&nbsp;&nbsp;속</td>
								<td class="tab_b0101" colspan=3>
                  <input id="txt_vend_nm" type="text" class="txt_a01"  style="width:150px;" disabled>
								</td>
							</tr>

							<tr>
								<td class="tab_a0101">사업구분</td>
								<td class="tab_b0101">
									<comment id="__NSID__"><object id=gcra_ct classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
											style="position:relative;left:4px;top:0px;height:24;width:200;cursor:hand;">
											<param name=Cols     value="2">
											<param name=CodeValue  value="">
											<param name=Format   value="c^사업자,t^관광객">
									</object></comment><script>__ws__(__NSID__);</script>	
								</td> 
							</tr>
							<tr>
   							<td class="tab_a0101">전화번호</td>
								<td class="tab_b0101" colspan=3>
                  <input id="txt_tel_sid" type="hidden" class="txt_a01"  style="width:200px;">
                  <input id="txt_tel_num" type="text" class="txt_a01"  style="width:200px;" disabled>
								</td>
							</tr>
							<tr>
								<td class="tab_a0101">업무구분</td>
								<td class="tab_b0101">
									<comment id="__NSID__"><object id=gcra_op classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
											style="position:relative;left:4px;top:0px;height:24;width:200;cursor:hand;">
											<param name=Cols      value="2">
											<param name=CodeValue value="O">
											<param name=Format    value="O^업무,P^개인">
									</object></comment><script>__ws__(__NSID__);</script>	
								</td> 
							</tr>
							<tr>
								<td class="tab_a0101">통화일자</td>
								<td class="tab_b0101">
                  <!-- <input id="txt_tel_date" type="text" class="txt_a01"  style="width:80px;"> -->
									<fieldset class=field_01 style="width:67px;">
									<comment id="__NSID__"><OBJECT id=gcem_tel_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										class="gcem_01" style="width:62px;">
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
											<param name=Enable			  value="true">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
									</fieldset>
								</td> 
							</tr>
							<tr>
								<td class="tab_a0101">통화시작시간</td>
								<td class="tab_b0101">
									<fieldset class=field_01 style="width:60px;">
									<comment id="__NSID__"><OBJECT id=gcem_tel_stime classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										class="gcem_01" style="width:55px;">
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=Format	      value="00:00.00">
											<param name=PromptChar	  value="">
											<param name=Enable			  value="true">
                      <param name=UpperFlag	    value=1>
									</OBJECT></comment><script>__ws__(__NSID__);</script>
									</fieldset>
								</td> 
							</tr>
							<tr>
								<td class="tab_a0101">통화종료시간</td>
								<td class="tab_b0101">
									<fieldset class=field_01 style="width:60px;">
									<comment id="__NSID__"><OBJECT id=gcem_tel_etime classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										class="gcem_01" style="width:55px;">
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=Format	      value="00:00.00">
											<param name=PromptChar	  value="">
											<param name=Enable			  value="true">
						                      <param name=UpperFlag	    value=1>
									</OBJECT></comment><script>__ws__(__NSID__);</script>
									</fieldset>
								</td> 
							</tr>
							<tr>
								<td class="tab_a0101">사용시간</td>
								<td class="tab_b0101">
									<fieldset class=field_01 style="width:80px;">
									<comment id="__NSID__"><OBJECT id=gcem_tel_dura classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										class="gcem_01" style="width:76px;">
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=Format	      value="000">
											<param name=PromptChar	  value="">
											<param name=Enable			  value="true">
						                      <param name=UpperFlag	    value=1>
									</OBJECT></comment><script>__ws__(__NSID__);</script>
									</fieldset>
								</td> 
							</tr>
							<tr>
								<td class="tab_a0101">요&nbsp;금($)</td>
								<td class="tab_b0101">
									<fieldset class=field_01 style="width:80px;">
									<comment id="__NSID__"><OBJECT id=gcem_tel_fee classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										class="gcem_01" style="width:75px;top:0px;">
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=MaxDecimalPlace   value=2>
											<param name=MaxLength value=3>
											<param name=PromptChar	  value="">
											<param name=Enable			  value="true">
						                      <param name=UpperFlag	    value=1>
									</OBJECT></comment><script>__ws__(__NSID__);</script>
											</fieldset>
<!--								  <input id="gcem_tel_fee" type="text" class="txt_a01"  style="width:80px;" maxlength="5">//-->
									&nbsp;&nbsp;남 : <comment id="__NSID__"><OBJECT id=gcem_11 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										class="gcem_01" style="width:35px;top:4px;">
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=MaxDecimalPlace   value=2>
											<param name=MaxLength value=3>
											<param name=PromptChar	  value="">
											<param name=Enable			  value="false">
						                      <param name=UpperFlag	    value=1>
									</OBJECT></comment><script>__ws__(__NSID__);</script>
									&nbsp;북 : <comment id="__NSID__"><OBJECT id=gcem_12 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										class="gcem_01" style="width:35px;top:4px;">
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=MaxDecimalPlace   value=2>
											<param name=MaxLength value=3>
											<param name=PromptChar	  value="">
											<param name=Enable			  value="false">
						                      <param name=UpperFlag	    value=1>
									</OBJECT></comment><script>__ws__(__NSID__);</script>
								</td> 
							</tr>
							<tr>
								<td class="tab_a0100">정산여부</td>
								<td class="tab_b0100">
									<comment id="__NSID__"><object id=gcra_cal_yn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
											style="position:relative;left:4px;top:0px;height:24;width:200;cursor:hand;">
											<param name=Cols     value="2">
											<param name=CodeValue  value="N">
											<param name=Format   value="Y^완료,N^미정산">
									</object></comment><script>__ws__(__NSID__);</script>	
								</td> 
							</tr>

						</table>
  				</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table>
		<tr>&nbsp;</tr>
			<tr>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp3 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:877px;height:300px;" viewastext>
										<param name="DataID"				value="gcds_data_3">
										<param name="HeadBorder" 		value="4">
										<param name="HeadLineColor" value="#A4B8C5">
										<param name="LineColor" 		value="#A4B8C5">
										<param name="TitleHeight"		value="22">
										<param name="RowHeight"			value="20">
										<param name=HiddenVScroll value="false">
										<param name="BorderStyle" 	value="0">
										<param name="ColSizing" 		value="1">
										<param name="FillArea" 			value="1">
										<param name="ViewUnbind" 		value="-1">
										<param name="UsingOneClick" value=1>
										<param name="sortview"			value=left>
										<param name="Format"				value="
											<F> Name='No.'				ID={CURROW} 	HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center </F>
											<C> Name='TELHIS_SID'		ID=TELHIS_SID			HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=center show=false</C> 
											<C> Name='사업자번호'		ID=CUST_SID			HeadAlign=Center HeadBgColor=#EEEEEE Width=0		align=center </C> 
											<C> Name='사업구분'		ID=CT			HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=center EditStyle=Combo Data='c:사업자,t:관광객'</C> 
											<C> Name='TEL_SID'		ID=TEL_SID			HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=center show=false </C> 
											<C> Name='전화번호'		ID=TEL_NUM			HeadAlign=Center HeadBgColor=#EEEEEE Width=110		align=center</C>
											<C> Name='통화일자'		ID=TEL_DATE			HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=center mask='XXXX/XX/XX'</C> 
											<C> Name='시작시간'		ID=TEL_STIME			HeadAlign=Center HeadBgColor=#EEEEEE Width=90		align=center mask='XX:XX.XX'</C> 
											<C> Name='종료시간'		ID=TEL_ETIME			HeadAlign=Center HeadBgColor=#EEEEEE Width=90		align=center mask='XX:XX.XX'</C> 
											<C> Name='사용시간'		ID=TEL_DURA			HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=center </C> 
											<C> Name='요금'		ID=TEL_FEE			HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=center </C> 
											<C> Name='정산여부'		ID=CAL_YN			HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=center EditStyle=Combo Data='Y:정산,N:미정산'</C> 
											<C> Name='OP'		ID=OP			HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=center show=false EditStyle=Combo Data='O:업무,P:개인'</C> 
											<C> Name='실제통화자'		ID=WORK_NO			HeadAlign=Center HeadBgColor=#EEEEEE Width=120		align=center </C> 
											<C> Name='I_EMPNO'		ID=I_EMPNO			HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=center show=false</C> 
											<C> Name='U_EMPNO'		ID=U_EMPNO			HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=center show=false</C> 
											">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
				</tr>
</table>
<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcbn_data3 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_data_3>
	<param name=ActiveBind    value=true>	
	<param name=BindInfo			value='
		<C>Col=CT  Ctrl=gcra_ct	 Param=CodeValue</C>
		<C>Col=TEL_SID  Ctrl=txt_tel_sid	 Param=value</C>
		<C>Col=TEL_NUM  Ctrl=txt_tel_num	 Param=value</C>
		<C>Col=TEL_DATE  Ctrl=gcem_tel_date	 Param=text</C>
		<C>Col=TEL_STIME  Ctrl=gcem_tel_stime	 Param=text</C>
		<C>Col=TEL_ETIME Ctrl=gcem_tel_etime Param=text</C>
		<C>Col=TEL_DURA  Ctrl=gcem_tel_dura	 Param=text</C>
		<C>Col=TEL_FEE    Ctrl=gcem_tel_fee	   Param=tex</C>
		<C>Col=CAL_YN    Ctrl=gcra_cal_yn	   Param=CodeValue</C>
		<C>Col=WORK_NO    Ctrl=txt_work_no	   Param=value</C>
		<C>Col=OP    Ctrl=gcra_op	   Param=CodeValue</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 
<!--------------------------------- 코딩 부분 끝 --------------------------------->
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>