<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	통화 관리
+ 프로그램 ID	: bm055i
+ 기 능 정 의	: 조회|수정|저장
+ 변 경 이 력	: KBJ
+ 서 블 릿 명	: bm055i_s01,bm055i_s02,bm055i_s03,bm055i_t01,bm055i_t02, bm055i_t03,bm055i_chk_s01
------------------------------------------------------------------------------>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<jsp:include page="/Sales/common/include/head.jsp"/>
<Script language="javascript" src="../common/include/PubFun.js">
    <link rel="stylesheet" href="../common/include/common.css">
</script>
<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
	get_cookdata();
  var gs_date = gn_Replace(gcurdate,"/");
	var gdataset = "";


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
    ln_Query1();
    ln_Query2();
    ln_Query3();
    
		ln_Enable('f');
	}

	/******************************************************************************
		Description : 조회(무전기 조회)
	******************************************************************************/
	function ln_Query1(){			
		gcds_data_1.DataID = "/services/servlet/sales.bm.bm055i_s01";
		gcds_data_1.Reset();
	}

	/******************************************************************************
		Description : 조회(직원 조회)
	******************************************************************************/
	function ln_Query2(){
		gcds_data_2.DataID = "/services/servlet/sales.bm.bm055i_s02";
		gcds_data_2.Reset();
	}

	/******************************************************************************
		Description : 조회(무전기 지급현황 조회)
	******************************************************************************/
	function ln_Query3(){
		gcds_data_3.DataID = "/services/servlet/sales.bm.bm055i_s03";
		gcds_data_3.Reset();
	}

	/******************************************************************************
		Description : 등록
	******************************************************************************/
	function ln_Add(){ 
		if (gcds_data_1.RowStatus(gcds_data_1.RowPosition) == 1 ){
					return false;
		}
		
		gcds_data_1.addrow();

		var row = gcds_data_1.rowposition;
		if(gcds_data_1.sysStatus(row)=="1"){
			 ln_Enable('t');

			 gcds_data_1.NameValue(gcds_data_1.rowposition,"I_EMPNO") = gusrid;
		}

	}

	//Description : 저장
	function ln_Save(){

		if (!gcds_data_1.isUpdated) {
			alert(gn_Msg(4));
			return;
		}

		if (!ln_Valchk()) return;

		gctr_data.KeyValue = "bm055i_t01(I:DATA=gcds_data_1)";
	    gctr_data.Action = "/services/servlet/sales.bm.bm055i_t01";
	    //prompt("",gcds_data.text);
		gctr_data.post();

		ln_Enable('f');

	    ln_Query1();
	    ln_Query2();
	    ln_Query3();
	}

	/******************************************************************************
		Description : 지급
	******************************************************************************/
	function ln_Give(){
		var row = gcds_data_1.rowposition;
		var str1 = gs_date.substring(0,4)+gs_date.substring(5,7)+gs_date.substring(8,10);
		var str2 = gcds_data_2.NameValue(gcds_data_2.rowposition,"CUST_SID");
		//if (!ln_Valchk()) return;
		gcds_data_1.deleterow(row);
		gctr_data.KeyValue = "bm055i_t02(I:DATA=gcds_data_1)";
		gctr_data.Action = "/services/servlet/sales.bm.bm055i_t02";
		gctr_data.Parameters = "v_str1=" +  str1 + ",v_str2=" + str2 + ",v_str3=" + fn_trim(gusrid);
		gctr_data.post();

    ln_Query1();
    ln_Query2();
    ln_Query3();
	}

	/******************************************************************************
		Description : 회수(잠시대기)
	******************************************************************************/
	function ln_Get(){
		var row = gcds_data_3.rowposition;
    
		gcds_data_3.deleterow(row);
		gctr_data.KeyValue = "bm055i_t03(I:DATA=gcds_data_3)";
		gctr_data.Action = "/services/servlet/sales.bm.bm055i_t03";
		gctr_data.Parameters = "v_str1=" + fn_trim(gusrid);
		gctr_data.post();

	    ln_Query1();
	    ln_Query2();
	    ln_Query3();
	}
	//Description : 삭제
	function ln_Delete(){
		if (gcds_data_1.countrow<1) {
			alert(gn_Msg(4));
			return;
		}

		var row = gcds_data_1.rowposition;
		if (gcds_data_1.sysStatus(row)=="1") gcds_data_1.undo(row);
		else {
			if (!confirm(gn_Msg(3))) return;
			gcds_data_1.deleterow(row);
			gctr_data.KeyValue = "bm055i_t01(I:DATA=gcds_data_1)";
			gctr_data.Action = "/services/servlet/sales.bm.bm055i_t01";
			gctr_data.post();
		}

    ln_Query1();
    ln_Query2();
    ln_Query3();
	}
	//Description : 엑셀
	function ln_Excel(){

	}

	//Description : 사원(팝업)
	function ln_SrhEmpno(){
		var strURL = "bm051i_r.html";
		var strPos = "dialogWidth:435px;dialogHeight:475px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");
		
		txt_cust_sid.value   = firstList[0]; 
		txt_cdname_fr.value  = firstList[1]; 
	} 

	//Description : 입력값 체크
	function ln_Valchk(){ 
		//키값중복체크
		var row = gcds_data_1.rowposition;
		if(gcds_data_1.sysStatus(row)=="1"){
			  //null값체크
				if(gcds_data_1.NameValue(gcds_data_1.rowposition,"RT_SERIAL")=null  || gcds_data_1.NameValue(gcds_data_1.rowposition,"RT_SERIAL")=="" ){
					 alert("시리얼 넘버는 필수 입력사항입니다.");
					 return false;
				}

        //중복값 체크
				gcds_chk.DataID = "/services/servlet/sales.bm.bm055i_chk_s01?v_str1="+gcds_data_1.NameValue(gcds_data_1.rowposition,"RT_SERIAL");
				gcds_chk.Reset();

				if(gcds_chk.namevalue(1,"RT_SERIAL") != 0){
					alert("중복된 시리얼 번호가 있습니다.");
					gcds_data_1.namevalue(row,"RT_SERIAL") = "";
					//gcds_data_1.deleterow(row);
					return;
				}				
		}

		return true;

	}

	//Description : Enable Format
	function ln_Enable(chk){
		if (chk == "t") {
       gcgd_disp1.Editable = 'true';
		}else if(chk == "f") {
       gcgd_disp1.Editable = 'false';
		}
	}
</script>
<!--	D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N	-->
<comment id="__NSID__"><OBJECT id=gcds_data_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data_3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
	gn_LoadComp_NonAlert('1',gcds_data_1.countrow);
</script>

<script language="javascript" for="gcds_data_2" event="OnLoadStarted()">
	gn_LoadStart();
</script>

<script language="javascript" for="gcds_data_2" event="onloadCompleted(row,colid)">
	gn_LoadComp_NonAlert('2',gcds_data_2.countrow);
</script>

<script language="javascript" for="gcds_data_3" event="OnLoadStarted()">
	gn_LoadStart();
</script>

<script language="javascript" for="gcds_data_3" event="onloadCompleted(row,colid)">
	gn_LoadComp_NonAlert('3',gcds_data_3.countrow);
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
</script>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="820" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px">
	<tr> 
		<td  align="right" style="padding-top:4px;" colspan=3>
			<img src="/services/Sales/images/excel.gif"	style="position:relative;top:-5px;" align=absmiddle onclick="ln_Excel()">		
		</td>
	</tr>
	<tr>
		<td width="330"><b>무전기조회</b></td><td width="330"><b>직원조회</b></td>
	</tr>
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp1 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:370px;height:180px;" viewastext>
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
							<param name="Editable"      value="true">
							<param name="sortview"			value=left>
							<param name="Format"				value="  
								<F> Name='No.'		ID={CURROW} 	HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center show=false</F>
									<C> Name='RT_SID'		  ID=RT_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=150	align=center show=false</C> 
									<C> Name='모델명'		  ID=RT_MODEL		HeadAlign=Center HeadBgColor=#EEEEEE Width=170	align=center</C> 
									<C> Name='Serial No'		ID=RT_SERIAL	HeadAlign=Center HeadBgColor=#EEEEEE Width=150	align=center</C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:372px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
						</fieldset>
					</td>


          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp2 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:400px;height:180px;" viewastext>
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
								<C> Name='CUST_SID'		  ID=CUST_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=150	align=center show=false</C> 
								<C> Name='팀명'		  ID=TEAM_NM			HeadAlign=Center HeadBgColor=#EEEEEE Width=130	align=center</C> 
								<C> Name='실무번호'	ID=WORK_NO			HeadAlign=Center HeadBgColor=#EEEEEE Width=120	align=center</C> 
								<C> Name='성명'		  ID=CUST_NM			HeadAlign=Center HeadBgColor=#EEEEEE Width=110	align=center</C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div2 style="width:402px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt2 style="position:relative;top:4px;left:8px"></font>
						</fieldset>
					</td>
				</tr>
			<table width="820" border="0">
				<tr >
				  <td style="padding-top:4px;">
						<img src="/services/Sales/images/plus.gif"	style="position:relative;top:0px;left:100px;cursor:hand;" align=absmiddle onClick="ln_Add()">
						<img src="/services/Sales/images/save.gif"	style="position:relative;top:0px;left:100px;cursor:hand;" align=absmiddle onClick="ln_Save()">
						<img src="/services/Sales/images/minus.gif" style="position:relative;top:0px;left:100px;cursor:hand;	" align=absmiddle onClick="ln_Delete()">
					</td>
					</tr>


		<tr align="center">
		<td>
			<img src="/services/Sales/images/com_btn_up.gif"  width = "40" style="position:relative;left:-17px;cursor:hand" onclick="ln_Get()">&nbsp;&nbsp;
			<img src="/services/Sales/images/com_btn_down.gif" width = "40" style="position:relative;left:-17px;cursor:hand" onclick="ln_Give()">
		</td>
		</tr>


			  <tr><td><b>무전기 지급 현황</b></td></tr>
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp3 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:815px;height:250px;" viewastext>
							<param name="DataID"				value="gcds_data_3">
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
								<F> Name='No.'				ID={CURROW} HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center show=false</F>
								<C> Name='CUST_SID'		  ID=CUST_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=150	align=center show=false</C>
								<C> Name='RT_SID'		  ID=RT_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=150	align=center show=false</C>
								<C> Name='팀명'		  ID=TEAM_NM	HeadAlign=Center HeadBgColor=#EEEEEE Width=180 	align=left</C>
								<C> Name='실무번호'	ID=WORK_NO	HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center</C>
								<C> Name='성명'		  ID=CUST_NM	HeadAlign=Center HeadBgColor=#EEEEEE Width=90  	align=center</C>
								<C> Name='모델명'		  ID=RT_MODEL		HeadAlign=Center HeadBgColor=#EEEEEE Width=150	align=center</C>
								<C> Name='Serial No'		ID=RT_SERIAL	HeadAlign=Center HeadBgColor=#EEEEEE Width=150	align=center</C>
								<C> Name='지급일'		ID=RT_DATE	HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center	mask='XXXX/XX/XX'</C>
								<C> Name='소속회사'	ID=VEND_NM	HeadAlign=Center HeadBgColor=#EEEEEE Width=140	align=left show=false</C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div3 style="width:817px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt3 style="position:relative;top:4px;left:8px"></font>
						</fieldset>
					</td>
        </tr>
	</table>

</table>
<!--------------------------------- 코딩 부분 끝 --------------------------------->
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
</BODY>