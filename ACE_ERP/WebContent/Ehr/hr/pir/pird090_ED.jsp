<!--
***********************************************************************
* @source      : pird091_ED.jsp
* @description : 직원인명사진첩 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/08      김학수        최초작성.
***********************************************************************
-->

<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>


<%@page import ="java.io.*"%>

<%@page import ="java.awt.Image"%>
<%@page import ="javax.imageio.ImageIO"%>
<%@page import ="java.awt.image.BufferedImage"%>
<%@page import ="javax.swing.ImageIcon"%>

<%@page import ="common.util.ImgUtil" %>
<%@page import ="elsoft.extquery.extquery"%>
<%@page import ="com.shift.gef.support.vo.* "%>
<%@page import ="com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%@page import ="com.shift.gef.configuration.Configuration"%>
<%@page import ="com.shift.gef.core.exception.CException"%>

<%
		System.out.println("START!");

		Configuration conf = Configuration.getInstance();

		String ENO_NO   = request.getParameter("ENO_NO");
	    String PRT_GBN  = request.getParameter("PRT_GBN");
		String FILEURL  = "";
		FILEURL = conf.get("framework.file.upload.pds");
	    String eno_path = "";


	    /** 외부 XML에서 직원인명사진첩 데이터 조회 SQL 읽음 **/
	    String sql = XmlSqlUtils.getSQL("pir", "PIRD090_SHR");

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
	    Object[] bind = new Object[] {
	             ENO_NO,                       //사번
	             ENO_NO,                      //사번
	             ENO_NO                       //사번
	    };


	    AbstractDAO aaa= new AbstractDAO("default");

	    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

		extquery hnwExtQuery = new extquery();

		hnwExtQuery.AddField("소속");
		hnwExtQuery.AddField("직위");
		hnwExtQuery.AddField("성명");
		hnwExtQuery.AddField("생년월일");
	    hnwExtQuery.AddField("그룹입사일");
	    hnwExtQuery.AddField("입사일");
	    hnwExtQuery.AddField("현직위승진일");
	    hnwExtQuery.AddField("현소속발령일");
	    hnwExtQuery.AddField("졸업 학교");
	    hnwExtQuery.AddField("졸업 학과");
	    hnwExtQuery.AddField("본적");
		hnwExtQuery.AddField("ENO_NO");
		hnwExtQuery.AddField("ENO_IMG");

		hnwExtQuery.SendField(response);



	       if (voList.size() > 0)
	       {
	           for ( int i=0; i<voList.size(); i++ )
	           {
	               DynamicValueObject vo = (DynamicValueObject)voList.get(i);

		        hnwExtQuery.AddData(vo.getString("DPT_NM"));
	            hnwExtQuery.AddData(vo.getString("JOB_NM"));
	            hnwExtQuery.AddData(vo.getString("ENO_NM"));
	            hnwExtQuery.AddData(vo.getString("BIR_YMD"));
	            hnwExtQuery.AddData(vo.getString("HIRG_YMD"));
	            hnwExtQuery.AddData(vo.getString("HIR_YMD"));
	            hnwExtQuery.AddData(vo.getString("JPR_YMD"));
	            hnwExtQuery.AddData(vo.getString("DPA_YMD"));
	            hnwExtQuery.AddData(vo.getString("SCH_NM"));
	            hnwExtQuery.AddData(vo.getString("MAJ_NM"));
	            hnwExtQuery.AddData(vo.getString("PER_ADR"));
	            hnwExtQuery.AddData(vo.getString("ENO_NO"));

	       		eno_path = FILEURL+"/"+ vo.getString("ENO_NO") + ".jpg";

	       		File   eno_file = new java.io.File(eno_path);

				hnwExtQuery.AddData(eno_file);

				hnwExtQuery.SendData(response);
	      }

	    }

				hnwExtQuery.EndData(response);
%>


