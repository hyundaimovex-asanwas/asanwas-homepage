<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:	����ƻ� ���� P/L �� C/I ����
+ ���α׷� ID	:	TR00210.HTML
+ �� �� �� ��	:	���� P/L �� C/I ����
+ �� �� �� ��	:	���̼�
+ �ۼ����� :
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� :
+ �������� :
----------------------------------------------------------------------------------
+ ������ :
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="transfer.common.*"%>
<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath �� ��Ÿ ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());
%>


<!-- HTML ����-->
<html>
	<head>
   <jsp:include page="/Transfer/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script ����
=============================================================================*/
%>



<SCRIPT language=JavaScript>
	
	get_cookdata();

	var lb_boolean1 =  false ; 
	var gs_ordno = null ; 
	var gs_plno = null ; 
	var gs_seq = null ; 
    var gs_date = '<%=firstday%>';
	var gs_date1 = gs_date.substring(0,6) + "01";

	/*----------------------------------------------------------------------------
	 * �������ε�
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!

			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]

			Start();//����ȸ

			window.status="�Ϸ�";

		}
	/******************************************************************************
		Description :
	******************************************************************************/ 
	function Start(){

		gcDs_etc1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0002";  //Project 
		gcDs_etc1.Reset();
		
		gcDs_etc2.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0003";  //��ǰ���� 
		gcDs_etc2.Reset(); 

		PL_FLAG.index = 1 ; 

		ETD_DATE.Text = gs_date ; 
	}
 
	/******************************************************************************
		Description :
	******************************************************************************/ 
	function ln_Query(){
		var parm = "&gstr6=" + ORDER_NO.Text
						 + "&gstr11=" + ETD_DATE.Text
						 + "&gstr4=" + LINE_PART.BindColVal
						 + "&gstr12=I"
						 + "&gstr10=" + CUST_NM.value ; 

		gcDs1.DataId =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsMakePl?NOH=Y&gstr1=A"  +parm; 
		gcDs1.Reset() ; 
	}

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function ln_Excel(){
		ExcelDialog(Grid1,'���� PL �� CI ����Ʈ') ; 
	}

	/******************************************************************************
		Description : PACKING LIST ��û
	******************************************************************************/ 
	function MakingPl(){
		var row =  null ; 
		var ls_plflag = null ; 
		var ls_check = null ; 
		var ls_cnt1  =  0 ; 
		var batch_orderno = '' ; 

		for(var ls_cnt=1; ls_cnt<=gcDs1.CountRow; ls_cnt++){
		  ls_plflag = gcDs1.NameValue(ls_cnt,"PL_TYPE" ) ; 
		  ls_check = gcDs1.NameValue(ls_cnt,"CHECK" ) ; 

	    if(	ls_plflag == "Y" && ls_check=="T" ){ // Pl��û�� �ǵ�
				MakingPl_Y(ls_cnt) ;  
			} else if( ls_plflag != "Y" && ls_check=="T" && ls_plflag != "C")	{    
				batch_orderno = batch_orderno + gcDs1.NameValue(ls_cnt,"ORDER_NO") + '/' ; 
				ls_cnt1++;
			}  
		}

		if( ls_cnt1 > 0 ) { 
			window.location.href="../../Transfer/html/TR00211.html?gstr1=make&gstr2="+batch_orderno+"&" + LINE_PART.bindcolval + "/" + ETD_DATE.text ; 
		} else alert("PL �ۼ��� ���� �ֹ������� ������ �ֽʽÿ�.");
	}

	/******************************************************************************
		Description : PL���� ��û�� PACKING  LIST �ۼ�
	******************************************************************************/ 
	function MakingPl_Y(row){
		var order_no = gcDs1.NameValue(row,"ORDER_NO") ; 
		 
		gcTr01.KeyValue = "trMakingPl(I:USER=gcDs1)";
		gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trMakingPl";
		gcTr01.post();
		gcDs1.Reset(); 
	}

</SCRIPT>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcDs1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"><param name=UseChangeInfo    value=true>  
</OBJECT> 

<OBJECT id=gcDs2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT> 

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT> 

<OBJECT id=gcDs_etc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"><param name=UseChangeInfo    value=false>  
</OBJECT> 

<OBJECT id=gcDs_etc2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT> 
<%=HDConstant.COMMENT_END%>
 <!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id="gcTr01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--�ֹ� ������-->
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=Grid1 event=OnClick(row,colid)> 
	if (colid=="CHECK"){
		if( gcDs1.NameValue(row,"PL_TYPE") == "C" || gcDs1.NameValue(row,"PL_TYPE") == "A" ){
			alert("Packing List �� �����մϴ�. " ) ; 
		} else {
			var ls_chk = gcDs1.namevalue(row,colid);
			if (strim(ls_chk)=="" || strim(ls_chk)=="F") gcDs1.namevalue(row,colid) = "T";
			else gcDs1.namevalue(row,colid) = gcDs1.OrgNameValue(row,colid);
		}
	}
</script>

<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s07.jsp"  flush="true"/>
<BODY>
	<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr>
			<td><img src="../img/TR00110_head_1.gif"></td>
			<td width="685" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">
				<img src="../img/btn/b_plwrite.gif"  style='cursor:hand' onclick="MakingPl();" >
				<img src="../../common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel();">
				<img src="../../common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query();">
			</td>
		</tr>
		<tr>
			<td colspan=2>
			  <table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab11" bgcolor="#eeeeee" style="height:30px;width:100px;">��������</td>
						<td class="tab11_left" style="width:140px">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ETD_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:4px; width:63px;height:17px;font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../img/btn_calendar.gif" style="position:relative;left:10px;top:1px;cursor:hand" onclick="__GetCallCalendar('ETD_DATE', 'Text');"> 
						</td>
						<td class="tab11" bgcolor="#eeeeee"  width=100>�ֹ���ȣ</td>
						<td class="tab11_left">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ORDER_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:3px; width:70px;height:17px;font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="##########">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>   
						</td>
						<!--
						<td class="tab11" bgcolor="#eeeeee"  width=100>����/����</td>
						<td class="tab13_left" style="width:150px">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=IO_FLAG style='border:0;position:relative;left:8px;top:1px;height:150' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=90>
								<param name=CBData					value="O^����,I^����">
								<param name=CBDataColumns		value="DIVCODE,DIVNAME">
								<param name=SearchColumn		value=DIVNAME>
								<param name=Index						value=0>
								<param name=ListExprFormat	value="DIVNAME^0^90">								
								<param name=BindColumn			value="DIVCODE">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
						<!-- <td class="tab11" bgcolor="#eeeeee"  width=75>
							&nbsp;PROJECT
						</td>
						<td class="tab11_left"  >&nbsp;
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=from_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:0px;top:3px; width:70px;height:17px;font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="#############">
								<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>   
							 
						</td>  -->
						<td class="tab11" style="width:100px;" bgcolor="#eeeeee">PL/CI��û</td>
						<td class="tab13_left" style="width:150px;">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=PL_FLAG style='border:0;position:relative;left:8px;top:1px;height:150' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=90>
								<param name=CBData					value="Y^������û,N^�Ϲ�">
								<param name=CBDataColumns		value="DIVCODE,DIVNAME">
								<param name=SearchColumn		value=DIVNAME>
								<param name=Sort						value=True>
								<param name=ListExprFormat	value="DIVNAME^0^50">								
								<param name=BindColumn			value="DIVCODE">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr> 
					<tr>
						<td class="tab12" bgcolor="#eeeeee" style="height:30px;width:100px;">��ü��</td>
						<td class="tab12_left"><input id="CUST_NM" name="CUST_NM" type="text" class="txt11" style='width:205;position:relative;left:8px;top:0px'></td> 
						<td class="tab12" bgcolor="#eeeeee">Project</td>
						<td>
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=LINE_PART  style='border:0;position:relative;left:8px;top:1px;height:110;width:160px;' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 >
								<param name=ComboDataID			value=gcDs_etc1>  
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value=True>
								<param name=ListExprFormat	value="MINORNM^0^160">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value=0>
								<param name=InheritColor		value="true"> 
								<param name=ComboStyle			value=2>
							</OBJECT>
							<%=HDConstant.COMMENT_END%> 
						</td> 
						<td colspan=2></td>
					</tr>
				</table> 
			</td>
		</tr> 
		<tr><td height=5></td></tr>
		<tr>
			<td colspan=2> 
				<table  cellpadding="0" cellspacing="0" border="0" style="width:876px;height:300px;font-size:9pt;background-color:#ffffff;border:1 solid #708090" >
					<!-- <tr><td bgcolor="#eeeeee" align=right class=tab11><input id="txt_hobby1" name="txt_hobby1" type="text" class="txt31" style='width:54;position:relative;left:0px;top:-2px' value=" �������� : ">&nbsp;
					<%=HDConstant.COMMENT_START%>
					<OBJECT id=Project classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:0px;top:3px;font-size:12px;width:130px;"  >
									<param name=ComboDataID			value="gcds_before">
									<param name=CBDataColumns		value="INFODIV, DSPNM">
									<param name=SearchColumn		value="DSPNM">
									<param name=Sort						value="false">
									<param name=ListExprFormat	value="DSPNM^0^250">
									<param name=BindColumn			value="INFODIV">
								</OBJECT>
								<%=HDConstant.COMMENT_END%>&nbsp;&nbsp;
								<%=HDConstant.COMMENT_START%>
								<OBJECT id=tb_Radio classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0  style="height:15; width:135"> 
                           <param name=Cols     value="3"> 
                           <param name=Format value="1^��ü,2^����,3^����"> 
                     </OBJECT>
                     <%=HDConstant.COMMENT_END%>  &nbsp;&nbsp;&nbsp;
					</td><td bgcolor="#eeeeee" align=right class=tab11> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  <%=HDConstant.COMMENT_START%>
					  <OBJECT id=tb_Radio classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 
                       style="height:15; width:150"> 
                           <param name=Cols     value="3"> 
                           <param name=Format value="1^��ü,2^����,3^����"> 
                     </OBJECT>
                     <%=HDConstant.COMMENT_END%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="../img/btn/b_save.gif" style="cursor:hand" style="position:relative;left:0px;top:2px" onclick="ln_Query()">
					</td>
					</tr>  -->
					<tr><td height=20 bgcolor=#FFFF99 colspan=2><B>&nbsp;&nbsp;�ֹ����� : </B></td></tr>
					<tr>
						<td colspan=2>
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=Grid1 style="width:100%;height:401px;border:0 solid #777777;border-top-width:1px;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"		VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="0">
								<param name="AllShowEdit" VALUE="true">
								<PARAM NAME="Format"			VALUE="  
									<F> Name='��'					ID='CHECK'		HeadAlign=Center HeadBgColor=#eeeeee Width=20		align=center EditStyle=CheckBox, cursor=hand, edit=none, bgcolor=@ucolor</F>
									<F> Name='No.'				ID='SeralNo' 	HeadAlign=Center HeadBgColor=#e8e8e8 Width=40		align=center bgcolor='#efefef' value={ToString(RowCount-CurRow+1)}	</F> 
									<F> Name='PL��û'			ID=PL_TYPE		HeadAlign=Center HeadBgColor=#eeeeee Width=60		align=center edit=none Value={Decode(PL_TYPE,'Y','������û','C','�Ϸ�','A','�Ϸ�','�Ϲ�')}</C></F> 
									<C> Name='PL/CI No'   ID=PL_NO			HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center edit=none</C> 
									<C> Name='�ֹ���ȣ'   ID=ORDER_NO		HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center edit=none</C> 
									<C> Name='����'       ID=ORDER_STS	HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center , editstyle=combo Data='0001:���,0002:����,0003:����/������,0004:�߰����' edit=none</C>  
									<C> Name='���Կ�û����'   ID=ETD_DT			HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center MASK ='XXXX-XX-XX' edit=none</C>
									<C> Name='��������'   ID=EDT_DATE			HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center MASK ='XXXX-XX-XX' edit=none</C> 
									<C> Name='Project��'  ID=LINE_PART	HeadAlign=Center HeadBgColor=#eeeeee Width=100		align=left EditStyle=Lookup Data='gcDs_etc1:MINORCD:MINORNM' edit=none</C> 
									<C> Name='������ �δ�'   ID=CDNAM			HeadAlign=Center HeadBgColor=#eeeeee Width=180  align=left edit=none</C> 
									<C> Name='��û��ü��' ID=CUST_NM		HeadAlign=Center HeadBgColor=#eeeeee Width=160  align=left edit=none</C> 
									<C> Name='�����'     ID=CUST_PRSN  HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=left edit=none</C>  
								 	<C> Name='ȭ��'       ID=SHIPPER_NM HeadAlign=Center HeadBgColor=#eeeeee Width=160  align=left edit=none</C> 
								 	<C> Name='�����'     ID=SHIPPERPS  HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=left edit=none</C>  
									<C> Name='���籸��'		ID=CARGO_TYPE HeadAlign=Center HeadBgColor=#eeeeee Width=80	align=center , editstyle=LookUp Data='gcDs_etc2:MINORCD:MINORNM' edit=none</C> 
								">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr> 
				</table> 

			</td>
		</tr> 
	</table>
</BODY>
</HTML>
