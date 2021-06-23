<%--
  - 작성자: 이소연
  - 일자: 2006.07.03
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 마이페이지>나의예약보기
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.reservation.bean.Reservation_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.ReservationInfo"%>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
   int cust_sid	= Util.parseInt(request.getParameter("cust_sid"), 0);
   String manage_no = "";
   String regi_no = "";
   String regi_no1 = "";
   String regi_no2 = "";
   String regi_yn = "";
   String tel_no = "";
   String tel_no1 = "";
   String tel_no2 = "";
   String tel_no3 = "";
   String mobile_no = "";
   String mobile_no1 = "";
   String mobile_no2 = "";
   String mobile_no3 = "";
   String zip_cd = "";
   String zip_cd1 = "";
   String zip_cd2 = "";
   String address1 = "";
   String address2 = "";
   String company_nm = "";
   String positions = "";
   String cust_nm = "";
   String saveDirName = "reservationUserLink";
   String userImage = "";
   
if (cust_sid > 0){
    
	//DAO
	ReservationInfo dao = new ReservationInfo();
       //DTO
	Reservation_bean bean[] = dao.getCustInfo(cust_sid);

System.out.println("--------------55 Line--------------------");
	
	cust_nm   = bean[0].getCust_nm();
	manage_no = bean[0].getManage_no();
	regi_no   = bean[0].getRegi_no();
	if (regi_no !=""){
	   regi_no1 = regi_no.toString().substring(0,6);
	   regi_no2 = regi_no.toString().substring(6,13);
	}

System.out.println("--------------62 Line--------------------");
	
	regi_yn   = bean[0].getRegi_yn();
	tel_no    = bean[0].getTel_no();
	mobile_no = bean[0].getMobile_no();
	zip_cd    = bean[0].getZip_cd();
	if (zip_cd !=""){
	   zip_cd1 = zip_cd.toString().substring(0,3);
	   zip_cd2 = zip_cd.toString().substring(3,6);
	}
	
System.out.println("--------------73 Line--------------------");
	
	address1 = bean[0].getAddress1();
	address2 = bean[0].getAddress2();
	tel_no = bean[0].getTel_no();

	//if (tel_no !=""){
	//   tel_no1 = Utility.getTel(tel_no,1);
	//   tel_no2 = Utility.getTel(tel_no,2);
	//   tel_no3 = Utility.getTel(tel_no,3);
	//}

System.out.println("--------------84 Line--------------------");
	
	mobile_no = bean[0].getMobile_no();
	//if (mobile_no !=""){
	//   mobile_no1 = Utility.getTel(mobile_no,1);
	//   mobile_no2 = Utility.getTel(mobile_no,2);
	//   mobile_no3 = Utility.getTel(mobile_no,3);
	//}	
	company_nm = bean[0].getCompany_nm();
	positions = bean[0].getPositions();

System.out.println("--------------84 Line--------------------");

    File systemFile = null;
    String saveDir  =  Config.getInstance().getProperty("imjkmd","reservationUserUpload");
    systemFile = new File(saveDir+regi_no+".jpg");

System.out.println("--------------90 Line--------------------");    
    
    if(systemFile.exists()){
      userImage = "/asanway/upload/reservationUserUpload/"+regi_no+".jpg";
    }else{
    
    }

System.out.println("--------------98 Line--------------------");    
    
}else{

}


%>

<html>
<head>
<title> 금강산관광   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript">
<!--
function _private_trim()
{
		var strTemp = this;
		 alert(strTemp);
		if ( strTemp.length > 0 )
		{
			while ( strTemp.substring(0, 1) == " " )
					strTemp = strTemp.substring(1);
			while ( strTemp.substring(strTemp.length - 1, strTemp.length) == " " )
					strTemp = strTemp.substring(0, strTemp.length - 1);
		}
		alert(strTemp.length);
		return strTemp;
}
	
String.prototype.trim = _private_trim;

function chk(){	
	
	f = document.form;

	if(f.zip_cd1.value==""){
		alert("우편번호를 입력하세요.");
		return;
	}
	if(f.address1.value=="" || f.address1.value=="기본주소"){
		alert("기본주소를 입력하세요.");
		f.address1.value="";
		f.address1.focus();
		return;
	}
	if(f.address2.value=="" || f.address2.value=="상세주소"){
		alert("상세주소를 입력하세요.");
		f.address2.value="";
		f.address2.focus();
		return;
	}
	if(f.tel_no.value==""){
		alert("자택전화번호 를 입력하세요.");
		f.tel_no.focus();
		return;
	}	
	//if(f.tel_no2.value==""){
	//	alert("자택전화번호를 입력하세요.");
	//	f.tel_no2.focus();
	//	return;
	//}		
	//if(f.tel_no3.value==""){
	//	alert("자택전화번호를 입력하세요.");
	//	f.tel_no3.focus();
	//	return;
	//}
	if(f.mobile_no.value==""){
		alert("핸드폰번호 를 입력하세요.");
		f.mobile_no1.focus();
		return;
	}		
	//if(f.mobile_no2.value==""){
	//	alert("핸드폰번호를 입력하세요.");
	//	f.mobile_no2.focus();
	//	return;
	//}			
	//if(f.mobile_no3.value==""){
	//	alert("핸드폰번호를 입력하세요.");
	//	f.mobile_no3.focus();
	//	return;
	//}
	if(f.company_nm.value=="" || f.company_nm.value=="직장명" ){
		alert("직장명을 입력하세요.");
		f.company_nm.value="";
		f.company_nm.focus();
		return;
	}		
	if(f.positions.value=="" || f.positions.value=="직위"){
		alert("직위를 입력하세요.");
		f.positions.value="";
		f.positions.focus();
		return;
	}

    var realFileName = f.attachFile01.value;
	f.realFileName.value = realFileName;
	
	if(document.getElementById("imageAreaValue").innerHTML ==""){
		if(realFileName=="" && document.form.realFileYn.value !="Y"){
			alert("첨부파일을 등록하세요.");
			return;
		}
	}else{
      if( img_confirm()!="1"){
        return;
      }
    }
    
	var idx = f.manage_no.value;
	realFileName = realFileName.substring(idx);
	f.submit();
}

//이미지 싸이즈 고정
function resizeImg(obj){
	if(obj.width > 130){
		obj.width = 130;
	}
}

//첨부파일 미리보기
function img_preview() {
   var form = document.form;
   if(form.attachFile01.value !=""){
       var file = form.attachFile01.value;
       file = file.slice(file.indexOf("") + 1);
       var ext = file.split(".")[file.split(".").length -1].toLowerCase();
       if(ext != "jpg"){
          alert("첨부파일은 jpg 만 가능 합니다..");
          return;
       }else{

       }
   }else{
   
   }
  document.form.img_link.src = document.form.attachFile01.value;
}

function img_confirm() {
   var form = document.form;
   if(form.attachFile01.value !=""){
       var file = form.attachFile01.value;
       file = file.slice(file.indexOf("") + 1);
       var ext = file.split(".")[file.split(".").length -1].toLowerCase();
       if(ext != "jpg"){
          alert("첨부파일은 jpg 만 가능 합니다..");
          return -1;
       }else{
          return 1;
       }
   }else{
   
   }
  document.form.img_link.src = document.form.attachFile01.value;
}

function img_view(val) {
  if(val !=""){
    document.form.realFileYn.value = "Y"; //첨부파일 등록여부 확인
    document.form.img_link.src = val;
  }  
  
}

//우편번호찾기
function zip_search(val)
{
	window.open('/member/pop_search_zip.jsp?type=' + val,'','width=450,height=460,top=200,left=200,scrollbars=no');
}

//-->
</script>

</head>

<body class="popmargin" onload="img_view('<%=userImage%>')">

<!-- 팝업사이즈 : 500 * 514 -->
<table cellspacing="0" cellpadding="0" border="0" width="470">
<tr>
	<td>
			<!-- / 타이틀 -->
			<table cellspacing="0" cellpadding="0" border="0" width="470" height="65" class="bg_dblue">
			<tr valign="top">
				<td width="296" class="tpad_20 lpad_20"><img src="<%=imageServer%>/tour_img/mypage/pop_tit_useinfo.gif"></td>
				<td width="124" class="tpad_20"><img src="<%=imageServer%>/tour_img/mem/pop_logo.gif"></td>
			</tr>
			</table>
			<!-- 타이틀 / -->
<form method="post" name="form" action="reservation_user_ok.jsp"  encType="multipart/form-data">
<input type="hidden" name="cust_sid" value="<%=cust_sid%>">
<input type="hidden" name="manage_no" value="<%=manage_no%>">
<input type="hidden" name="saveDirName" value="<%=saveDirName%>">
<input type="hidden" name="realFileYn">
<input type="hidden" name="realFileName">
			<table cellspacing="0" cellpadding="0" border="0" width="470" style="margin-top:25px;">
			<tr>
				<td height="48" valign="top"><img src="<%=imageServer%>/tour_img/mypage/txt_useinfo.gif" hspace="13"></td>
			</tr>
			<tr>
				<td valign="top" align="center">
					<table cellspacing="0" cellpadding="0" border="0" width="442">
					<tr valign="top">
						<td width="150">
							<table width="130" cellspacing="0" cellpadding="0" border="0">
							<tr>
								<td>
								  <img src="<%=imageServer%>/tour_img/mypage/_temp_pic.gif" id="img_link" width="130" height="150"><!-- 사진 -->
								</td>
							</tr>
							<tr>
								<td align="center" class="tpad_10">								

								<div id="imageAreaValue"></div>
                                <span  style="position:relative;left:7px;top:0px;height:19;width:40;background-image:url(<%=imageServer%>/tour_img/btn/btn_s_filesch.gif);background-repeat:no-repeat;clip:rect(0 40 19 0)"><!-- 파일찾기 -->
                                <input  type='file' name='attachFile01' onchange="javascript:img_preview() "style="width:40;height:19;filter:alpha(opacity=0);" >
 
                                </span>	
								</td>
							</tr>
							</table>
						</td>
						<td width="292">
							<table width="292" cellspacing="0" cellpadding="0" border="0">
							<tr><td class="line_dg" colspan="2" height="1"></td></tr>
							<tr>
								<td height="29" width="81"><img src="<%=imageServer%>/tour_img/mypage/txt_useinfo01.gif"><!-- 성명 --></td>
								<td width="211"><input type="text" name="cust_nm" style="width:70px;" value="<%=cust_nm%>" readonly></td>
							</tr>
							<tr><td class="line_dg" colspan="2" height="1"></td></tr>
							<tr>
								<td height="29"><img src="<%=imageServer%>/tour_img/mypage/txt_useinfo02.gif"><!-- 주민번호 --></td>
								<td><input type="text" name="regi_no1" style="width:68px;" value="<%=regi_no1%>" readonly> - 
								    <input type="text" name="regi_no2" style="width:69px;" value="<%=regi_no2%>" readonly></td>
							</tr>
							<tr><td class="line_dg" colspan="2" height="1"></td></tr>
							<tr>
								<td height="29"><img src="<%=imageServer%>/tour_img/mypage/txt_useinfo03.gif"><!-- 우편번호 --></td>
								<td><input type="text" name="zip_cd1" style="width:40px;" value="<%=zip_cd1%>" readonly> - 
								    <input type="text" name="zip_cd2" style="width:40px;" value="<%=zip_cd2%>" readonly>
								<a href="javascript:zip_search('reservation');"><img src="<%=imageServer%>/tour_img/btn/btn_s_postsch.gif" hspace="5" align="absmiddle"></a><!-- 우편번호검색 --></td>
							</tr>
							<tr><td class="line_dg" colspan="2" height="1"></td></tr>
							<tr>
								<td height="29"><img src="<%=imageServer%>/tour_img/mypage/txt_useinfo04.gif"><!-- 기본주소 --></td>
								<td><input type="text" name="address1" value="<%=address1%>" style="width:203px;"></td>
							</tr>
							<tr><td class="line_dg" colspan="2" height="1"></td></tr>
							<tr>
								<td height="29"><img src="<%=imageServer%>/tour_img/mypage/txt_useinfo05.gif"><!-- 상세주소 --></td>
								<td><input type="text" name="address2" value="<%=address2%>" style="width:203px;"></td>
							</tr>
							<tr><td class="line_dg" colspan="2" height="1"></td></tr>
							<tr>
								<td height="29"><img src="<%=imageServer%>/tour_img/mypage/txt_useinfo06.gif"><!-- 자택전화 --></td>
								<td><input type="text" name="tel_no" value="<%=tel_no%>" style="width:151px;"> </td>
							</tr>
							<tr><td class="line_dg" colspan="2" height="1"></td></tr>
							<tr>
								<td height="29"><img src="<%=imageServer%>/tour_img/mypage/txt_useinfo07.gif"><!-- 핸드폰 --></td>
								<td><input type="text" name="mobile_no" value="<%=mobile_no%>" style="width:151px;"> </td>
							</tr>
							<tr><td class="line_dg" colspan="2" height="1"></td></tr>
							<tr>
								<td height="29"><img src="<%=imageServer%>/tour_img/mypage/txt_useinfo08.gif"><!-- 직장명 --></td>
								<td><input type="text" name="company_nm" value="<%=company_nm%>" style="width:151px;"></td>
							</tr>
							<tr><td class="line_dg" colspan="2" height="1"></td></tr>
							<tr>
								<td height="29"><img src="<%=imageServer%>/tour_img/mypage/txt_useinfo09.gif"><!-- 직위 --></td>
								<td><input type="text" name="positions" value="<%=positions%>" style="width:151px;"></td>
							</tr>
							<tr><td class="line_dg" colspan="2" height="1"></td></tr>
							</table>
						</td>
					</tr>
					</table>
				</td>
			</tr>
			<tr><td height="29"></td></tr>
			<tr>
				<td height="39" valign="top" align="center">
				<a href="javascript:chk();"><img src="<%=imageServer%>/tour_img/btn/btn_confirm2.gif"></a><!-- 확인 -->
				<a href="javascript:self.close();"><img src="<%=imageServer%>/tour_img/btn/btn_mem_cancel2.gif"></a><!-- 취소 -->
				</td>
			</tr>
			</table>
</form>
			<!-- 하단바  --><table cellspacing="0" cellpadding="0" border="0" width="100%" height="8" class="bg_dblue"><tr><td></td></tr></table>
	</td>
</tr>
</table>

</body>
</html>
