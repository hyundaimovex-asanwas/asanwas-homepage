<!--
*****************************************************
* @source       : body.jsp
* @description : MAIN PAGE :: ���� ����
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/08/29      ������        �����ۼ�.
* 2006/09/12      �輮��        Main ȭ�� Scroll ó��
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>

<!-- Potential�� ����� ����ϱ� ���ؼ��� �ݵ�� �������� ��� �κп� ���ǰ� �Ǿ��� �־�� �Ѵ�. -->
<script>var frame; try {frame = window.external.GetFrame(window);}catch(e){alert(window.name);alert("frame �ʱ�ȭ ����");}</script>

<html>
<head>
<title>body frame</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >

//�޴����� ����(child frame���� ���)
var idColumn = "PGM_ID";//ID �÷���
var nameColumn = "PGM_NM";//�ش� name �÷���
var levelColumn = "LEVEL";//�ش� level �÷���
var flagColumn = "DIVIDE";//�ش� flag �÷���

/********************************************
	* 13. Form Load �� Default �۾� ó�� �κ�  *
********************************************/
function fnc_OnLoadProcess(){
	ds_UserInfo.DataId="/menu/LeftMenu_data.csv";
	ds_UserInfo.Reset();
}

//���� ǥ��
function getWinStat(strID, winstat)
{
	//opener.frame.Provider("MDIManager1").FrameShow("showdefault");
}

//â�ȿ����� �̺�Ʈ�� catch�Ͽ� �ش� function�� call�Ѵ�.
frame.SetEvent("onwinstat", getWinStat);

</script>
</head>

<!--
**************************************************************
* ���콺 ������Ʈ ���� �� �̺�Ʈ (Ʈ������, �����ͼ�) : (Visible : X)
**************************************************************
-->

<!-- �޴����� �� ���� �����ͼ�-->
<comment id="__NSID__">
<object id=ds_UserInfo classid=CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB>
	<param name=Syncload	value="true">
</object>
</comment><SCRIPT>__ShowEmbedObject(__NSID__);</SCRIPT>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="css/general.css" rel="stylesheet" type="text/css">

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" scroll="auto" >
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td valign="top" background="/images/common/mainBg.gif" style="padding: 15 20 30 20">

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
    <tr valign="middle">
        <td align="center">
            <img src="/images/common/batang2.gif" width="434" height="429">
        </td>
    </tr>
</table>

<!--

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center"> <table width="210" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="11" height="24" align="center" valign="top" bgcolor="E8EED6"><img src="/images/specialHr/gridWhiteLT.gif" width="11" height="11"></td>
					<td align="center" valign="bottom" bgcolor="E8EED6" style="font-weight:bold">2006
						<img src="/images/specialHr/formTitle.gif" width="71" height="17" align="absmiddle"></td>
					<td width="11" align="center" valign="top" bgcolor="E8EED6"><img src="/images/specialHr/gridWhiteRT.gif" width="11" height="11"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td bgcolor="E8EED6">

            <!--���������̺� ���� ->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="11" height="11"><img src="/images/specialHr/gridWhiteLT.gif" width="11" height="11"></td>
					<td height="11"></td>
					<td width="11"><img src="/images/specialHr/gridWhiteRT.gif" width="11" height="11"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="center" valign="top" style="padding-bottom:11px;">
						<table width="775" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="top" style="padding:0 0 7 4;"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle">
									<img src="/images/specialHr/formT1.gif" width="46" height="15" align="absmiddle"> <B>(�Ϲݱ�)</B>
								</td>
							</tr>
							<tr>
								<td class="hrWtable" style="padding:10 6 6 6">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="25" align="center" valign="top" background="/images/specialHr/formLineBg.gif"><img src="/images/specialHr/inputT4.gif" width="116" height="20"></td>
											<td width="13" rowspan="3" background="/images/specialHr/dotV.gif"></td>
											<td align="center" valign="top" background="/images/specialHr/formLineBg.gif"><img src="/images/specialHr/inputT5.gif" width="116" height="20"></td>
											<td width="13" rowspan="3" background="/images/specialHr/dotV.gif"></td>
											<td align="center" valign="top" background="/images/specialHr/formLineBg.gif"><img src="/images/specialHr/inputT8.gif" width="116" height="20"></td>
										</tr>
										<tr>
											<td align="center"><img src="/images/specialHr/inputImg4.gif" width="116" height="80"></td>
											<td align="center"><img src="/images/specialHr/inputImg5.gif" width="116" height="80"></td>
											<td align="center"><img src="/images/specialHr/inputImg6.gif" width="116" height="80"></td>
										</tr>
										<tr>
											<td height="23" align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">2006-12-04
												~ 2006-12-07</td>
											<td align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">2006-12-14
												~ 2006-12-16</td>
											<td align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">2006-12-22
												~ 2006-12-29</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<!--���������̺� �� ->

		</td>
	</tr>
	<tr>
		<td height="3"></td>
	</tr>
	<tr>
		<td bgcolor="E8EED6">

			<!--���������̺� ���� ->
			<table width="100%" height="220" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>&nbsp;</td>
					<td align="center" valign="top" style="padding-top:7px;">
						<table width="775" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="top" style="padding:0 0 7 4;"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle">
									<img src="/images/specialHr/formT2.gif" width="44" height="15" align="absmiddle">
								</td>
							</tr>
							<tr>
								<td class="hrWtable" style="padding:10 6 6 6">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="25" align="center" valign="top" background="/images/specialHr/formLineBg.gif"><img src="/images/specialHr/inputT3.gif" width="116" height="20"></td>
											<td width="13" rowspan="3" background="/images/specialHr/dotV.gif"></td>
											<td align="center" valign="top" background="/images/specialHr/formLineBg.gif"><img src="/images/specialHr/inputT7.gif" width="116" height="20"></td>
											<td width="13" rowspan="3" background="/images/specialHr/dotV.gif"></td>
											<td align="center" valign="top" background="/images/specialHr/formLineBg.gif"><img src="/images/specialHr/inputT4.gif" width="116" height="20"></td>
											<td width="13" rowspan="3" background="/images/specialHr/dotV.gif"></td>
											<td align="center" valign="top" background="/images/specialHr/formLineBg.gif"><img src="/images/specialHr/inputT5.gif" width="116" height="20"></td>
											<td width="13" rowspan="3" background="/images/specialHr/dotV.gif"></td>
											<td align="center" valign="top" background="/images/specialHr/formLineBg.gif"><img src="/images/specialHr/inputT8.gif" width="116" height="20"></td>
										</tr>
										<tr>
											<td align="center"><img src="/images/specialHr/inputImg3.gif" width="116" height="80"></td>
											<td align="center"><img src="/images/specialHr/inputImg7.gif" width="116" height="80"></td>
											<td align="center"><img src="/images/specialHr/inputImg4.gif" width="116" height="80"></td>
											<td align="center"><img src="/images/specialHr/inputImg5.gif" width="116" height="80"></td>
											<td align="center"><img src="/images/specialHr/inputImg6.gif" width="116" height="80"></td>
										</tr>
										<tr>
											<td height="43" align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">2006-12-04 ����<br>2006-12-05 ����</td>
											<td align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">2006-12-06 ����<br>2006-12-07 ����</td>
											<td align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">2006-12-08 ����<br>2006-12-11 ����</td>
											<td align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">2006-12-14 ����<br>2006-12-16 ����</td>
											<td align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">2006-12-22 ����<br>2006-12-29 ����</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
                 		</td>
					<td width="11">&nbsp;</td>
				</tr>
				<tr>
					<td height="11" width="11"><img src="/images/specialHr/gridGreenLB.gif" width="11" height="11"></td>
					<td height="11"></td>
					<td><img src="/images/specialHr/gridGreenRB.gif" width="11" height="11"></td>
				</tr>
				<tr>
					<td colspan=2 ><font color="red">�� �� ȭ���� �� ���� ������ �����ִ� ȭ�� �Դϴ�. </td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;<td>
				</tr>
				<tr>
					<td colspan=2 ><font color="blue">�� �λ� �� �۾��� ����� '�λ���' �޴��� Ŭ�� �� ���� Ʈ�� �޴��� ��Ÿ���� [�λ���] �޴��� ���� Ŭ�� �Ͻʽÿ�!</td>
				</tr>
				<tr>
					<td colspan=2><font color="blue">&nbsp;&nbsp;&nbsp;�ش� �޴��� [������] �Ǵ� [������] �޴����� [�ڱ�����������]�� ���� �۾� �ϼ���!</td>
				</tr>
			</table>
			<!--���������̺� �� ->

		</td>
	</tr>
</table>

-->

		</td>
	</tr>
</table>
</body>
</html>