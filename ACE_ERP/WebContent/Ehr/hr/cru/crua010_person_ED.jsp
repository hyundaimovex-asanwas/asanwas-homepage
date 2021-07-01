<!--
***********************************************************************
* @source      : crua010_person_ED.jsp
* @description : 인원현황(기본)
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/02      방석호        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import ="com.shift.gef.core.exception.CException"%>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import ="com.shift.gef.gauce.utility.TrBox"%>
<%@page import ="com.shift.gef.support.collection.CBox"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%

	String REGNO     = request.getParameter("REGNO");
	String PASSTAG     = request.getParameter("PASSTAG");


    String sql = null;
    sql = XmlSqlUtils.getSQL("cru", "CRUA010_MAIN");

	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	Object[] bind = new Object[] {
			REGNO
	};

	 AbstractDAO aaa= new AbstractDAO("default");

     DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

     extquery hnwExtQuery = new extquery();


	/** 필드값 세팅 **/
		String 	colStr  =   "REG_NO,JUMIN,REGYY,REGCH,REGAPP,REGSEQ,ENO_NM,NAM_ENG,NAM_CHI,SEXGU,BIRYMD,BIRTAG,ORGADDR,WJOB1,WJOB2,WJOB3,MILYN,MILFREE,MILNO,MILSEC,MILGRD,MILPART,MILTERM,BDHEI,BDWEI,EYEL,EYER,HOBBOY,SKILL,RELSEC,AWDYN,POST,SIKUKN,ADDR,TEL1,TEL2,TEL3,HTEL1,HTEL2,HTEL3,REGYMD,EMAIL,ACPSTAT,AGE,MILYY,MILMM,PASSTAG,PASSTAG1,PASSTAG2,PASSTAG3,PASSTAG4,PASSTAG5,PASSEND1,PASSEND2,PASSEND3,PASSEND4,PASSEND5,SPLIT_FLAG,EMP_PIC,WANT_DPT1,WANT_DPT2,WANT_DPT3,FIN_DPT,ORGAREA,PAY,BLOOD,LIVE,MOVPOR,IMOVPOR,PHOTO,PASSWORD,SUBMITFG,LANGNM1,LANGLEV1,LANGNM2,LANGLEV2,LANGNM3,LANGLEV3,TOEIC,TOEFL,TESTNM,TESTGRD,TESTTGRD,PCTOOL1,PCABLE1,PCTOOL2,PCABLE2,PCTOOL3,PCABLE3,LICENCE1,LICENCE2,LICENCE3,LICENCE4,AWDNM1,AWDCO1,AWDYMD1,AWDRGD1,AWDNM2,AWDCO2,AWDYMD2,AWDRGD2,AWDNM3,AWDCO3,AWDYMD3,AWDRGD3,SOCFYMD1,SOCTYMD1,SOCACT1,SOCFYMD2,SOCTYMD2,SOCACT2,CLUBNM1,CLUBFOR1,CLUBACT1,CLUBNM2,CLUBFOR2,CLUBACT2,TRAVELNM1,TRAVELFYMD1,TRAVELTYMD1,TRAVELFOR1,TRAVELNM2,TRAVELFYMD2,TRAVELTYMD2,TRAVELFOR2,MYSTRY,MYCHAR,MYEMOT,MYVISION,COMCR,LANGMAN1,LANGJUM1,LANGMAN2,LANGJUM2,LANGMAN3,LANGJUM3,LANGMAN4,LANGJUM4,TOEICLEV,TOEFLLEV,LICYMD1,LICYMD2,LICYMD3,LICYMD4,TESTNM2,TESTNM3,PCTOOL4,PCABLE4,PYMD,PNAME,PAREA,MYMD,MNAME,MAREA,HYMD,HNAME,HMAJOR,HGRDYN,CYMD,CNAME,CMAJOR,CGRDYN,EUYMD,EUNAME1,EUMAJOR,EUSEC,UYMD,UNAME1,UMAJOR,UGRDYN,GSYMD,GSNAME1,GSNAME2,GSMAJOR1,GSMAJOR2,GSGRDYN,AVE1,AVE2,AVE3,AVE4,TAVE,TALL,GRD1,GRD2,GRD3,TGRD,UAVE,GSAVE,UHAK,GSHAK";
		String[] values = colStr.split(",");
		for( int x = 0; x < values.length; x++ ){
			hnwExtQuery.AddField(values[x]);
		}
	    hnwExtQuery.SendField(response);

	    if (voList.size() > 0)
	    {
	        for (int i=0; i<voList.size(); i++)
	        {
	            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

	        	for( int x = 0; x < values.length; x++ ){
	                hnwExtQuery.AddData(vo.getString(values[x]));
	        	}
	            hnwExtQuery.SendData(response);
	        }
	    }
	    else
	    {
	    	// hnwExtQuery.AddData("데이터가 존재하지 않습니다.");
	    	for( int x = 0; x < values.length; x++ ){
	            hnwExtQuery.AddData("");
	    	}
	        hnwExtQuery.SendData(response);

	    }
%>