<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 협력업체 관리
 * 프로그램ID 	: thms204.HTML
 * J  S  P		: th204.jsp
 * 작 성 자		: 이동훈
 * 작 성 일		: 2010-10-07
 * 기능정의		: 공사관리용 협력업체 정보 (하도급회사)
 * [ 수정일자 ][수정자] 내용
 * [2011-06-16][심동현] 공사관리 쪽으로 통합
 * [2011-06-17][심동현] 협력업체 코드가 동훈이의 개발버젼테이블과 현재과장의 새 액셀 데이터와 다름!
 *						이 협력업체를 통합관리하는 걸 고려해야 하지 않나?
 *						회계 쪽에 등록완료 했다는 Flag가 하나 필요할지도..
 *  서블릿명 : thms_101_s.java, thms_101_t.java
 *****************************************************************************/
%>
<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>

<html>
<head>
<title>협력업체 관리</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="http://erp.hdasan.com/common/include/common.css">
 
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="http://erp.hdasan.com/common/include/PubFun.js"></script>


<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

	get_cookdata();       //읽기

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){

	ln_Before();		//선조회 조건



}


/******************************************************************************
	Description : 선조회 조건
******************************************************************************/
function ln_Before(){

	gclx_regyy.index = 1;

	ln_SetDataHeader();//gcds_data00 해더생성

	//현장
	gcds_regyy.DataID="<%=dirPath%>/servlet/construct.menu.th.thms_site_s?v_str1=0006";
	gcds_regyy.Reset();

	//공종
	gcds_cnst.DataID="<%=dirPath%>/servlet/construct.menu.th.thms_site_s?v_str1=0003";	
	gcds_cnst.Reset();

}


/******************************************************************************
	Description : Dataset Head 설정 - gcds_data00
******************************************************************************/
	function ln_SetDataHeader(){
			if(gcds_data00.countrow<1){
				var s_temp =  "COOP_CD:STRING(10),"		
									+"COOP_NM:STRING(50)," 			
									+"COOP_YYMM:STRING(10)," 		
									+"COOP_VGB:STRING(1)," 										
									+"COOP_CERT:STRING(15),"	
									+"COOP_DIRECT:STRING(20),"    											
									+"ADDRESS:STRING(20),"		
									+"COOP_STYLE:STRING(20),"
									+"CREAT_DT:STRING(10),"							
									+"LICENSE1:STRING(30),"			
									+"CON_CAPA1:DECIMAL(15,0),"   												
									+"LICENSE2:STRING(30),"	
									+"CON_CAPA2:DECIMAL(15,0),"  											
									+"LICENSE3:STRING(30),"	
									+"CON_CAPA3:DECIMAL(15,0),"  												
									+"DEBT_2008:STRING(20),"
									+"DEBT_2009:STRING(20),"
									+"DEBT_2010:STRING(20),"
									+"DEBT_2011:STRING(20),"
									+"CASH_2008:STRING(20),"
									+"CASH_2009:STRING(20),"
									+"CASH_2010:STRING(20),"
									+"CASH_2011:STRING(20),"
									+"CREDIT_2008:STRING(20),"
									+"CREDIT_2009:STRING(20),"
									+"CREDIT_2010:STRING(20),"
									+"CREDIT_2011:STRING(20),"
									+"DEFAULT:STRING(50),"			
									+"PATENT:STRING(50),"		
									+"RECOMMEND:STRING(50),"											
									+"VD_TELNO:STRING(15),"			
									+"VD_FAXNO:STRING(15),"		
									+"REMARK:STRING(100)"							
				gcds_data00.SetDataHeader(s_temp);		
		}
	}

/******************************************************************************
	Description : 기본조회
******************************************************************************/
function ln_Query(){

	gcds_data00.DataID = "<%=dirPath%>/servlet/construct.menu.th.thms_204_s1?"	 		
											 + "v_str1="+gclx_regyy.bindcolval						//등록년도
											 + "&v_str2="+gclx_cnst.bindcolval;						//업체구분

	gcds_data00.Reset(); 

}

/******************************************************************************
	Description : 저장  -   완성해야 됨!!!!
******************************************************************************/
function ln_Save(){

    //if(!ln_Save_Chk()) return;

	if (gcds_data00.IsUpdated) {	
		if (confirm("해당 입력정보를 저장하시겠습니까 ?")) {
			gctr_sys.KeyValue = "thms_204_t1?(I:USER=gcds_data00)";			
 			gctr_sys.action = "<%=dirPath%>/servlet/construct.menu.th.thms_204_t1?";
			gctr_sys.post();

		}
	}
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

        gcds_data00.AddRow();

		gcem_coopnm.Text = "";      		
		gcem_coopstyle.Text = "";      		
		gcem_coopcd.Text = "";		    
		gcem_coopcert.Text = "";      		
		gcem_coopaddress.Text = "";      	
		gcem_coopdirect.Text = "";	      	
		gcem_recommend.Text = "";	    		
		gcem_coopdebt_2008.Text = "";   
		gcem_coopdebt_2009.Text = "";   
		gcem_coopdebt_2010.Text = "";   
		gcem_coopcash_2008.Text = "";  
		gcem_coopcash_2009.Text = "";  
		gcem_coopcash_2010.Text = "";  
		gcem_coopcredit_2008.Text = "";      		
		gcem_coopcredit_2009.Text = "";      	
		gcem_coopcredit_2010.Text = "";      	
		gcem_cooplicense1.Text = "";      	
		gcem_cooplicense2.Text = "";      	
		gcem_cooplicense3.Text = "";      	
		gcem_coopcapa1.Text = "";	    
		gcem_coopcapa2.Text = "";      	
		gcem_coopcapa3.Text = "";     	
		gcem_coopdefault.Text = "";	    
		gcem_cooppatent.Text = "";  
		gcem_coopremark.Text = "";

		gcem_coopnm.focus();

}


/******************************************************************************
	Description : 엑셀
******************************************************************************/
  function ln_Excel(){

    var szName1 = "업체별 현황";
    var szPath = "C:\\Test\\현황.xls";
       if (gcds_data00.countrow<1){
          alert("다운로드 하실 자료가 없습니다");
       }
       else{
          gcgd_disp.GridToExcel(szName1,szPath,2);
       }
   }


</script>

<!-- 공종명  -->
<script language="javascript" 	for="gcds_cnst" event="onloadCompleted(row,colid)">
	gcds_cnst.namevalue(1,"COM_CODE") = "";
	gcds_cnst.namevalue(1,"COM_SNAME") = "전체";
	gclx_cnst.index = 0;
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<comment id="__NSID__">
<OBJECT id=gcds_data00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<OBJECT id=gcds_regyy classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<OBJECT id=gcds_cnst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<comment id="__NSID__">
<object id=gctr_data00 classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-- 업체 조회 -->
<script language="javascript" for="gcds_data00" event="OnLoadStarted()">
			window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
			document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data00" event="onloadCompleted(row,colid)">
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt1.innerText = "조회건수 : " + row + " 건";
			if (row <1) {
			alert("검색된 데이터가 없습니다.");
			}
</script>

<script language=JavaScript for=gctr_data00 event=OnFail()>
	alert("Error Code : " + gctr_data00.ErrorCode + "\n" + "Error Message : " + gctr_data00.ErrorMsg + "\n");
</script>

<script language=JavaScript for=gctr_data00 event=OnSuccess()>
    alert("저장에 성공하였습니다");
	ln_Query();		
</script>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
</head>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<!--------------------------------- 코딩 부분 시작 ------------------------------->	
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px" height="47" background="http://erp.hdasan.com/common/img/com_t_bg.gif">
<tr> 
			<td width="876" height = "30" align="right" background="http://erp.hdasan.com/common/img/com_t_bg.gif">
						<img src="http://erp.hdasan.com/common/img/btn/com_b_newadd.gif" style="position:relative;top:3px;cursor:hand" onclick="ln_Add()">
						<img src="http://erp.hdasan.com/common/img/btn/com_b_save.gif" style="position:relative;top:3px;cursor:hand" onclick="ln_Save()">
						<img src="http://erp.hdasan.com/common/img/btn/com_b_excel.gif" style="position:relative;top:3px;cursor:hand" onclick="ln_Excel()">	
						<img src="http://erp.hdasan.com/common/img/btn/com_b_query.gif" style="position:relative;top:3px;cursor:hand" onclick="ln_Query()">								

			</td>
</tr>
</table>

<table  cellpadding="0" cellspacing="0" border="1"  style='position:relative;;left:7px;width:870px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
		<tr> 
				<td class="tab21" style="height:30px;width:70px;" bgcolor="#eeeeee">&nbsp;&nbsp;등록년도</td>
				<td class="tab21">
				<comment id="__NSID__">
				<object id="gclx_regyy" classid="clsid:60109D65-70C0-425C-B3A4-4CB001513C69" style="position: relative; left: 5px; top: 1px; font-size: 12px; width: 320px">
								<param name="ComboDataID" value="gcds_regyy" />
								<param name="CBDataColumns" value="COM_CODE, COM_SNAME" />
								<param name="SearchColumn" value="COM_SNAME" />
								<param name="Sort" value="false" />
								<param name="Index" value="0" />
								<param name="ListExprFormat" value="COM_SNAME^0^320" />
								<param name="BindColumn" value="COM_CODE" />
				</object>
				</comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab21" style="height:30px;width:70px;" bgcolor="#eeeeee">&nbsp;&nbsp;업체명</td>
				<td class="tab21"  colspan = "3">
				<comment id="__NSID__">
				<object id="gclx_cnst" classid="clsid:60109D65-70C0-425C-B3A4-4CB001513C69" style="position: relative; left: 5px; top: 1px; font-size: 12px; width: 320px">
										<param name="ComboDataID" value="gcds_cnst" />
										<param name="CBDataColumns" value="COM_CODE, COM_SNAME" />
										<param name="SearchColumn" value="COM_SNAME" />
										<param name="Sort" value="false" />
										<param name="Index" value="0" />
										<param name="ListExprFormat" value="COM_SNAME^0^320" />
										<param name="BindColumn" value="COM_CODE" />
				</object>
				</comment><script>__ws__(__NSID__);</script>
				</td>				
		</tr>

</table>




<table style ="position:relative" border="0" cellpadding="0" cellspacing="0" width="0">
	<tr>
		<td valign="top" bgcolor="#FFFFFF"style="padding-top:3px;">
			<table border = "0" cellpadding=0 cellspacing=0 style="width:620px;height:450px;float:left;left:3px;top:-1px">
				<tr height="1"><td></td></tr>
				<tr>
						<td width="0" style="padding-left:3px;">
										<comment id="__NSID__">
										<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp
										width="615" height="450" style="border:1 solid #708090" >
										<PARAM NAME="DataID"            VALUE="gcds_data00">
										<PARAM NAME="BorderStyle" VALUE="0">
										<PARAM NAME="Indwidth"      VALUE="0">
										<PARAM NAME="Fillarea"      VALUE="true">
										<PARAM NAME="Colsizing"     VALUE="true">
										<param name="editable"      value="true">
										<param name="sortview"     value=left>
										<PARAM NAME="Format"            VALUE="
										<F> Name=NO					ID={CurRow}       HeadAlign=Center   HeadBgColor=#B9D4DC Width=40,  align=center </F>
										<C>Name=코드,				ID=COOP_CD		HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=60,align=center sort = true </C>
										<C>Name=공사업체명,		ID=COOP_NM		HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center, sort = true  </C>
										<C>Name=등록년도,			ID=COOP_YYMM		HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=center, sort = true  </C>
										<C>Name=사업자등록번호,      ID=COOP_CERT	HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=110,align=center sort = true  </C>

										<C>Name=대표자,			ID=COOP_DIRECT			HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=90,align=center</C>
										<C>Name=소재지,			ID=ADDRESS					HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=90,align=center</C>
										<C>Name=업종,  				ID=COOP_STYLE			HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=설립일,  			ID=CREAT_DT				HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=center</C>

										<C>Name=면허1,  			ID=LICENSE1			HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=시공능력1,       ID=CON_CAPA1		HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=면허2,  			ID=LICENSE2			HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=시공능력2,       ID=CON_CAPA2		HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=면허3,  			ID=LICENSE3			HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=시공능력3,       ID=CON_CAPA3		HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>

										<G>Name=부채비율,     HeadBgColor=#B9D4DC, HeadAlign=center
										<C>Name=2008년,  	ID=DEBT_2008			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=2009년,  	ID=DEBT_2009			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=2010년,  	ID=DEBT_2010			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										</G>

										<G>Name=현금흐름,  	HeadBgColor=#B9D4DC, HeadAlign=center
										<C>Name=2008년,  	ID=CASH_2008			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=2009년,  	ID=CASH_2009			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=2010년,  	ID=CASH_2010			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										</G>

										<G>Name=신용도,  		HeadBgColor=#B9D4DC, HeadAlign=center
										<C>Name=2008년,  	ID=CREDIT_2008			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=2009년,  	ID=CREDIT_2009			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=2010년,  	ID=CREDIT_2010			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										</G>

										<C>Name=채무불이행,  ID=DEFAULT					HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=특허현황,  	ID=PATENT					HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=추천인,  		ID=RECOMMEND			HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=70,align=center</C>
										<C>Name=전화,  			ID=VD_TELNO			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=팩스,  			ID=VD_FAXNO			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=비고,  			ID=REMARK					HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=150,align=center</C>

										">
										</OBJECT>
										</comment><script>__ws__(__NSID__);</script>
										<fieldset style="width:615;height:25px;border:1 solid #708090;border-top-width:1px;text-align:left;">&nbsp;
										<font id=ft_cnt1 style="position:relative;top:4px;"></font>
										</fieldset>
						</td>
				</tr>
		</table>



          <td width=3> </td>



						<td valign=top align=left style="padding-top:3px;">


							<table  border="0" cellpadding="0" cellspacing="1" width="245px" bgcolor="#b5b5b5">
								<tr height="25">
									<td  align="center" bgcolor="#eeeeee" colspan="4"><B>기본항목</B>
									</td>
									</tr>

										<tr height="20">
										<td  align="center" bgcolor="#eeeeee" >업체명</td>
										<td bgcolor="#FFFFFF" colspan="3">
										<comment id="__NSID__">
										<object id="gcem_coopnm" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="width:180px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border				value=false>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>								
										</tr>

										<tr height="20">								
										<td  align="center" bgcolor="#eeeeee" >주업종</td>
										<td bgcolor="#FFFFFF"colspan="3">
										<comment id="__NSID__">
										<object id="gcem_coopstyle" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="width:180px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border				value=false>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>

										<tr height="20">									
										<td  align="center" bgcolor="#eeeeee">등록코드</td>
										<td bgcolor="#FFFFFF"colspan="3">
										<comment id="__NSID__">
										<object id="gcem_coopcd" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="width:180px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border				value=false>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>		

										<tr height="20">
										<td  align="center" bgcolor="#eeeeee" >사업자번호</td>
										<td bgcolor="#FFFFFF" colspan="3">
										<comment id="__NSID__">
										<object id="gcem_coopcert" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="width:180px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border				value=false>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>								
										</tr>

										<tr height="20">								
										<td  align="center" bgcolor="#eeeeee" >소재지</td>
										<td bgcolor="#FFFFFF"colspan="3">
										<comment id="__NSID__">
										<object id="gcem_coopaddress" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="width:180px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border				value=false>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>

										<tr height="20">									
										<td  align="center" bgcolor="#eeeeee">대표자</td>
										<td bgcolor="#FFFFFF"colspan="3">
										<comment id="__NSID__">
										<object id="gcem_coopdirect" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="width:180px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border				value=false>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>

										<tr height="20">									
										<td  align="center" bgcolor="#eeeeee">추천인</td>
										<td bgcolor="#FFFFFF"colspan="3">
										<comment id="__NSID__">
										<object id="gcem_recommend" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="width:180px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border				value=false>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>

									<tr height="5">
									<td  align="center" bgcolor="#FFFFFF" colspan="4"></td>
									</tr>
									<tr height="25">
										<td  align="center" bgcolor="#eeeeee" colspan="4"><B>신용도현황 </B>

										</td>
									</tr>

										<tr height="20">								
										<td  align="center" bgcolor="#eeeeee" >세부사항
										</td>
										<td  align="center" bgcolor="#eeeeee" >부채비율


										</td>
										<td  align="center" bgcolor="#eeeeee" >현금흐름


										</td>
										<td  align="center" bgcolor="#eeeeee" >신용도


										</td>
										</tr>

										<tr height="20">								
										<td  align="center" bgcolor="#eeeeee" >2008년</td>
										<td bgcolor="#FFFFFF" align="center">
										<comment id="__NSID__">
										<object id="gcem_coopdebt_2008" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:40px; height:18px; font-family:굴림; font-size:9pt ">
												<param name=Alignment			value=2>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										%</td>
										<td bgcolor="#FFFFFF" align="center">
										<comment id="__NSID__">
										<object id="gcem_coopcash_2008" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:60px; height:18px; font-family:굴림; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										<td bgcolor="#FFFFFF" align="center">
										<comment id="__NSID__">
										<object id="gcem_coopcredit_2008" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:55px; height:18px; font-family:굴림; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>

										<tr height="20">									
										<td  align="center" bgcolor="#eeeeee">2009년</td>
										<td bgcolor="#FFFFFF" align="center">
										<comment id="__NSID__">
										<object id="gcem_coopdebt_2009" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:40px; height:18px; font-family:굴림; font-size:9pt ">
												<param name=Alignment			value=2>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										%</td>
										<td bgcolor="#FFFFFF" align="center">
										<comment id="__NSID__">
										<object id="gcem_coopcash_2009" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:60px; height:18px; font-family:굴림; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										<td bgcolor="#FFFFFF" align="center">
										<comment id="__NSID__">
										<object id="gcem_coopcredit_2009" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:55px; height:18px; font-family:굴림; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>

										<tr height="20">
										<td  align="center" bgcolor="#eeeeee">2010년</td>
										<td bgcolor="#FFFFFF" align="center">
										<comment id="__NSID__">
										<object id="gcem_coopdebt_2010" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:40px; height:18px; font-family:굴림; font-size:9pt ">
												<param name=Alignment			value=2>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										%</td>
										<td bgcolor="#FFFFFF" align="center">
										<comment id="__NSID__">
										<object id="gcem_coopcash_2010" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:60px; height:18px; font-family:굴림; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										<td bgcolor="#FFFFFF" align="center">
										<comment id="__NSID__">
										<object id="gcem_coopcredit_2010" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:55px; height:18px; font-family:굴림; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>


										<tr height="5">
									<td  align="center" bgcolor="#FFFFFF" colspan="4"></td>
									</tr>
									<tr height="25">
										<td  align="center" bgcolor="#eeeeee" colspan="4"><B>건설업 면허</B>
										</td>
									</tr>


										<tr height="20">								
										<td  align="center" bgcolor="#eeeeee" rowspan = "3">시공능력 <br>(백만원)</td>
										<td bgcolor="#FFFFFF">
										<comment id="__NSID__">
										<object id="gcem_cooplicense1" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:18px; font-family:굴림; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										<td bgcolor="#FFFFFF" colspan="2">
										<comment id="__NSID__">
										<object id="gcem_coopcapa1" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:100px; height:18px; font-family:굴림; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Numeric			value=true>
												<param name=IsComma			value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>

										<tr height="20">								
										<td bgcolor="#FFFFFF">
										<comment id="__NSID__">
										<object id="gcem_cooplicense2" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:18px; font-family:굴림; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										<td bgcolor="#FFFFFF" colspan="2">
										<comment id="__NSID__">
										<object id="gcem_coopcapa2" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:100px; height:18px; font-family:굴림; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Numeric			value=true>
												<param name=IsComma			value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>

										<tr height="20">
										<td bgcolor="#FFFFFF">
										<comment id="__NSID__">
										<object id="gcem_cooplicense3" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:18px; font-family:굴림; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										<td bgcolor="#FFFFFF" colspan="2">
										<comment id="__NSID__">
										<object id="gcem_coopcapa3" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:100px; height:18px; font-family:굴림; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Numeric			value=true>
												<param name=IsComma			value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>


									<tr height="5">
									<td  align="center" bgcolor="#FFFFFF" colspan="4">
									</td>
									</tr>



									<tr height="25">
										<td  align="center" bgcolor="#eeeeee" colspan="4"><B>기타 </B>
										</td>
									</tr>	
									<tr height="20">							
										<td  align="center" bgcolor="#eeeeee">채무불이행</td>
										<td bgcolor="#FFFFFF" colspan="3">
										<comment id="__NSID__">
										<object id="gcem_coopdefault" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:180px; height:18px; font-family:굴림; font-size:9pt ">
												<param name=Alignment			value=0>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>										
									</tr>		
									<tr height="20">
										<td  align="center" bgcolor="#eeeeee">특허보유</td>
										<td bgcolor="#FFFFFF" colspan="3">
										<comment id="__NSID__">
										<object id="gcem_cooppatent" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:180px; height:18px; font-family:굴림; font-size:9pt ">
												<param name=Alignment			value=0>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>							
									</tr>									
									<tr height="20">							
										<td  align="center" bgcolor="#eeeeee">비고</td>
										<td bgcolor="#FFFFFF" colspan="3">
										<comment id="__NSID__">
										<object id="gcem_coopremark" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:180px; height:18px; font-family:굴림; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>								

									</tr>

								</td>
							</tr>            
						</table>
						</td>








	<!-- 기본탭 -->
<comment id="__NSID__">
	<OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="DataID"				VALUE="gcds_data00">
		<PARAM NAME="ActiveBind"		VALUE="true">
		<PARAM NAME="BindInfo"			VALUE="
			<C>Col=COOP_NM,				Ctrl=gcem_coopnm      						Param=Text</C>
			<C>Col=COOP_STYLE,			Ctrl=gcem_coopstyle      						Param=Text</C>
			<C>Col=COOP_CD,				Ctrl=gcem_coopcd		      					Param=Text</C>
			<C>Col=COOP_CERT,			Ctrl=gcem_coopcert      		  				Param=Text</C>
			<C>Col=ADDRESS,				Ctrl=gcem_coopaddress      					Param=Text</C>
			<C>Col=COOP_DIRECT,		Ctrl=gcem_coopdirect	      					Param=Text</C>
			<C>Col=DEBT_2008,			Ctrl=gcem_coopdebt_2008      				Param=Text</C>
			<C>Col=DEBT_2009,			Ctrl=gcem_coopdebt_2009      				Param=Text</C>
			<C>Col=DEBT_2010,			Ctrl=gcem_coopdebt_2010      				Param=Text</C>
			<C>Col=CASH_2008,			Ctrl=gcem_coopcash_2008      		 	Param=Text</C>
			<C>Col=CASH_2009,			Ctrl=gcem_coopcash_2009      		  	Param=Text</C>
			<C>Col=CASH_2010,			Ctrl=gcem_coopcash_2010      		  	Param=Text</C>
			<C>Col=CREDIT_2008,	    Ctrl=gcem_coopcredit_2008      		  	Param=Text</C>
			<C>Col=CREDIT_2009,		Ctrl=gcem_coopcredit_2009      		  	Param=Text</C>
			<C>Col=CREDIT_2010,    	Ctrl=gcem_coopcredit_2010      		  	Param=Text</C>
			<C>Col=LICENSE1,	  			Ctrl=gcem_cooplicense1      		  			Param=Text</C>	
			<C>Col=LICENSE2,	  			Ctrl=gcem_cooplicense2      		  			Param=Text</C>		
			<C>Col=LICENSE3,	  			Ctrl=gcem_cooplicense3      		  			Param=Text</C>	
			<C>Col=CON_CAPA1,	  		Ctrl=gcem_coopcapa1	      		  			Param=Text</C>	
			<C>Col=CON_CAPA2,	  		Ctrl=gcem_coopcapa2      		  			Param=Text</C>	
			<C>Col=CON_CAPA3,			Ctrl=gcem_coopcapa3      		  	  		Param=Text</C>	
			<C>Col=DEFAULT,				Ctrl=gcem_coopdefault	       					Param=Text</C>
			<C>Col=PATENT,	 	 			Ctrl=gcem_cooppatent      		  			Param=Text</C>
			<C>Col=RECOMMEND,	 	 	Ctrl=gcem_recommend      		  			Param=Text</C>
			<C>Col=REMARK,	 	 			Ctrl=gcem_coopremark      		  			Param=Text</C>
		">
	</OBJECT>
	</comment><script>__ws__(__NSID__);</script>





<!--------------------------------- 코딩 부분 끝 -------------------------------->
<comment id="__NSID__"><object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
	'>
</object></comment><script>__ws__(__NSID__);</script>
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 
</body>
</html>


