<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작 성 인 : 김종문
* 작성날자 : 2005년 10월 27일
* 요약설명 :
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>

<%
	String category = request.getParameter("category");
	String menuidx = "";
	if(category.equals("gallery")){
		menuidx = "17";
	}else{
		menuidx = "22";
	}
%>

<html>
<head>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>

<script language="javascript">
<!--
	function goInsert()
	{

		var form = document.form;

		if( form.title.value=="" )
		{
			alert("제목을 입력하세요.");
			form.title.focus();
			return false;
		}

		return true;

	}
	//-->
</script>
</head>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">

<jsp:include page="/asanway/common/top.jsp" flush="true" />
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="25" bgcolor="E4E3C3">
		<jsp:include page="/asanway/common/topbutton.jsp" flush="true" />
	</td>
  </tr>
  <tr>
    <td valign="top"><table width="850" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" ><table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td valign="top" bgcolor="FCFCF6">
					<jsp:include page="/asanway/cyber/left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">

				<SCRIPT Language="JavaScript">
				<!--

				//각 분류에 대한 배열
				List = new Array(5);
				List[0]=new Array(1);	// 현대아산
				List[1]=new Array(3);	// 관광사업
				List[2]=new Array(4);	// 개성공단
				List[3]=new Array(1);	// 건설사업
				List[4]=new Array(1);	// 기타경협사업

				// 0 현대아산
				List[0][0]="";

				// 1 관광사업
				List[1][0]="금강산";
				List[1][1]="개성";
				List[1][2]="백두산";

				// 2 개성공단
				List[2][0]="기록사진";
				List[2][1]="최근모습";
				List[2][2]="월별공사진행 현황";
				List[2][3]="공장건축공사 현황";

				// 3 건설사업
				List[3][0]="";

				// 4 기타경협사업
				List[4][0]="";



				//특정 채널을 선택하면 해당 카테고리를 생성
				function BuildList(num)
				{
				      //첫 번째 카테고리 선택
				      document.form.section2.selectedIndex=0;

				      //해당 채널의 서브 카테고리 배열 길이만큼 반복
				      for(ctr=0;ctr<List[num].length;ctr++)
				      {
					       //카테고리에 해당하는 콤보박스의 값을 채움
					       document.form.section2.options[ctr]=new Option(List[num][ctr], ctr);
				      }
				      //select 리스트 길이 지정
				      document.form.section2.length = List[num].length;
				}
				//-->
				</Script>

				<form name="form" method="post" action="cyber_gallery_insert.jsp" enctype="multipart/form-data" onSubmit="return goInsert()">
				<input type="hidden" name="category" value="<%= category %>">

                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b><%= category.equals("gallery")  ? "갤러리 등록" : "자료실 - 이미지 등록" %></b></td>
                    </tr>
                    <tr>
                      <td>


                      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="71">
                      <% if( category.equals("image") ) { %>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 25 ;">구분</td>
                            <td style="padding-left:5;">

		                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
		                          <tr>
		                            <td style="padding-left:5;" width="200">
		                            	<select name="section1"  OnChange="BuildList(this.selectedIndex);">
			                            	<option value="0">현대아산</option>
			                            	<option value="1">관광사업</option>
			                            	<option value="2">개성공단</option>
			                            	<option value="3">건설사업</option>
			                            	<option value="4">기타경협사업</option>
		                            	</select>
		                          	</td>
		                            <td height="30" width="75" bgcolor="F2F1E2" valign="top" style="padding: 10 0 0 25 ;">상세구분</td>
		                            <td style="padding-left:5;">
		                            	<select name="section2">
			                            	<option value="">---</option>
		                            	</select>
		                            </td>
		                          </tr>
                            	</table>

                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <% } %>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 25 ;">제목</td>
                            <td style="padding-left:5;"> <input type="text" name="title" size="20" maxlength="30" style="width:400px;height:20px" >
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 25 ;">이미지1</td>
                            <td style="padding-left:5;"> <input type="file" name="img1" style="width:300px;height:20px" >(* 권장 이미지 사이즈 : 600 * 400)
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 25 ;">이미지2</td>
                            <td style="padding-left:5;"> <input type="file" name="img2" style="width:300px;height:20px" >(* 권장 이미지 사이즈 : 600 * 400)
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 25 ;">이미지3</td>
                            <td style="padding-left:5;"> <input type="file" name="img3" style="width:300px;height:20px" >(* 권장 이미지 사이즈 : 600 * 400)
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 25 ;">이미지4</td>
                            <td style="padding-left:5;"> <input type="file" name="img4" size="50" style="width:300px;height:20px" >(* 권장 이미지 사이즈 : 600 * 400)
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 25 ;">이미지5</td>
                            <td style="padding-left:5;"> <input type="file" name="img5" style="width:300px;height:20px" >(* 권장 이미지 사이즈 : 600 * 400)
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;">
                        <div align="right">
	                        <!--  <a href="cyber_gallery_pop.jsp">	<img src="../img/bt_14.gif" width="58" height="20" hspace="4" border="0"></a> -->
	                        <input type="image" src="../img/bt_07.gif" width="40" height="20" border="0">
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td height="50" align="center">&nbsp;</td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                  </table>

                  </form>


                </td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td bgcolor="E4E3C3" height="10"></td>
  </tr>
  <tr>
    <td  height="15"></td>
  </tr>
  <tr>
    <td height="30"  bgcolor="D4D4B2">
		<jsp:include page="/asanway/common/copyright.jsp" flush="true" />
    </td>
  </tr>
</table>
</body>
</html>
