<!--
***********************************************************************
* @source      : crua010_ED01.jsp
* @description : 입사지원서 ㄱㅣ본정보 조회
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/18      이승욱        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import="com.shift.gef.core.exception.CException"%>
<%@page import="com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import="com.shift.gef.gauce.utility.TrBox"%>
<%@page import="com.shift.gef.support.collection.CBox"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%

    String REGYY      = request.getParameter("REGYY");
    String REGCH      = request.getParameter("REGCH");
    String REG_STR    = request.getParameter("REG_STR");
    String REG_END    = request.getParameter("REG_END");
    String SCHOOL     = request.getParameter("SCHOOL");
    String SPLIT_FLAG = request.getParameter("SPLIT_FLAG");
    String PASSTAG    = request.getParameter("PASSTAG");

    String sql = null;
    sql = XmlSqlUtils.getSQL("cru", "CRUA010_PR01");

    StringBuffer sb1  = new StringBuffer(); // 수허번호 From
    StringBuffer sb2  = new StringBuffer(); // 수험전호 To
    StringBuffer sb3  = new StringBuffer(); // 학력
    StringBuffer sb4  = new StringBuffer();

	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    if (!REG_STR.equals("")) {
        sb1.append("AND M.REG_NO >= '"+REG_STR+"'");
    }
    if ( !REG_END.equals("")) {
        sb2.append("AND M.REG_NO <= '"+REG_END+"'");
    }
    if ( SCHOOL.equals("2")) {
        sb3.append("AND (S.UNAME1 IS NOT NULL OR S.GSNAME1 IS NOT NULL)");
    } else if ( SCHOOL.equals("3")) {
        sb3.append("AND (S.UNAME1 IS NULL AND S.GSNAME1 IS NULL)");
    }
    if ( PASSTAG.equals("2")) {
        sb4.append("AND M.PASSTAG1 = 'Y'");
    } else if  ( PASSTAG.equals("3")) {
        sb4.append("AND M.PASSTAG2 = 'Y'");
    } else if  ( PASSTAG.equals("4")) {
        sb4.append("AND M.PASSTAG3 = 'Y'");
    } else if  ( PASSTAG.equals("5")) {
        sb4.append("AND M.PASSTAG4 = 'Y'");
    }

	Object[] sqlParam = new Object[] {
			sb1.toString(),
			sb2.toString(),
			sb3.toString(),
			sb4.toString()
	};

	/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/

    Object[] bind = new Object[] {
    REGYY, REGCH, SPLIT_FLAG
    };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("REG_NO");
    hnwExtQuery.AddField("REGAPP");
    hnwExtQuery.AddField("ENO_NM");
    hnwExtQuery.AddField("NAM_ENG");
    hnwExtQuery.AddField("NAM_CHI");
    hnwExtQuery.AddField("JUMIN_NO");
    hnwExtQuery.AddField("BIRYMD");
    hnwExtQuery.AddField("BIRTAG");
    hnwExtQuery.AddField("AGE");
    hnwExtQuery.AddField("ORGADDR");
    hnwExtQuery.AddField("WJOB1");
    hnwExtQuery.AddField("WJOB2");
    hnwExtQuery.AddField("WJOB3");
    hnwExtQuery.AddField("HYM");
    hnwExtQuery.AddField("HNAME");
    hnwExtQuery.AddField("CYM");
    hnwExtQuery.AddField("CNAME");
    hnwExtQuery.AddField("CMAJOR");
    hnwExtQuery.AddField("EUYM");
    hnwExtQuery.AddField("EUNAME");
    hnwExtQuery.AddField("EUMAJOR");
    hnwExtQuery.AddField("EUSEC");
    hnwExtQuery.AddField("UMYM");
    hnwExtQuery.AddField("UNAME");
    hnwExtQuery.AddField("UMAJOR");
    hnwExtQuery.AddField("UGRDYN");
    hnwExtQuery.AddField("GSYM");
    hnwExtQuery.AddField("GSNAME1");
    hnwExtQuery.AddField("GSNAME2");
    hnwExtQuery.AddField("GSMAJOR1");
    hnwExtQuery.AddField("GSMAJOR2");
    hnwExtQuery.AddField("GSGRDYN");
    hnwExtQuery.AddField("UAVE");
    hnwExtQuery.AddField("GSAVE");
    hnwExtQuery.AddField("UHAK");
    hnwExtQuery.AddField("GSHAK");
    hnwExtQuery.AddField("BDHEI");
    hnwExtQuery.AddField("BDWEI");
    hnwExtQuery.AddField("EYEL");
    hnwExtQuery.AddField("EYER");
    hnwExtQuery.AddField("C_EYEL");
    hnwExtQuery.AddField("C_EYER");
    hnwExtQuery.AddField("BLOOD");
    hnwExtQuery.AddField("AWDYN");
    hnwExtQuery.AddField("LIVE");
    hnwExtQuery.AddField("MOVPOR");
    hnwExtQuery.AddField("IMOVPOR");
    hnwExtQuery.AddField("SIKUKN");
    hnwExtQuery.AddField("ADDR");
    hnwExtQuery.AddField("LPOST");
    hnwExtQuery.AddField("RPOST");
    hnwExtQuery.AddField("TEL1");
    hnwExtQuery.AddField("TEL2");
    hnwExtQuery.AddField("TEL3");
    hnwExtQuery.AddField("HTEL1");
    hnwExtQuery.AddField("HTEL2");
    hnwExtQuery.AddField("HTEL3");
    hnwExtQuery.AddField("EMAIL");
    hnwExtQuery.AddField("LANGNM1");
    hnwExtQuery.AddField("LANGLEV1");
    hnwExtQuery.AddField("LANGNM2");
    hnwExtQuery.AddField("LANGLEV2");
    hnwExtQuery.AddField("LANGLEV2");
    hnwExtQuery.AddField("LANGNM3");
    hnwExtQuery.AddField("LANGLEV3");
    hnwExtQuery.AddField("TOEIC");
    hnwExtQuery.AddField("TOEFL");
    hnwExtQuery.AddField("TESTNM");
    hnwExtQuery.AddField("LANGJUM1");
    hnwExtQuery.AddField("TESTNM2");
    hnwExtQuery.AddField("LANGMAN2");
    hnwExtQuery.AddField("LANGJUM2");
    hnwExtQuery.AddField("TESTNM3");
    hnwExtQuery.AddField("LANGMAN3");
    hnwExtQuery.AddField("LANGJUM3");
    hnwExtQuery.AddField("LICENCE1");
    hnwExtQuery.AddField("LICENCE2");
    hnwExtQuery.AddField("LICENCE3");
    hnwExtQuery.AddField("AWDNM1");
    hnwExtQuery.AddField("AWDCO1");
    hnwExtQuery.AddField("AWDYMD1");
    hnwExtQuery.AddField("AWDNM2");
    hnwExtQuery.AddField("AWDCO2");
    hnwExtQuery.AddField("AWDYMD2");
    hnwExtQuery.AddField("AWDNM3");
    hnwExtQuery.AddField("AWDCO3");
    hnwExtQuery.AddField("AWDYMD3");
    hnwExtQuery.AddField("PCTOOL1");
    hnwExtQuery.AddField("PCABLE1");
    hnwExtQuery.AddField("PCTOOL2");
    hnwExtQuery.AddField("PCABLE2");
    hnwExtQuery.AddField("PCTOOL3");
    hnwExtQuery.AddField("PCABLE3");
    hnwExtQuery.AddField("MILYN");
    hnwExtQuery.AddField("MILFREE");
    hnwExtQuery.AddField("MILSEC");
    hnwExtQuery.AddField("MILGRD");
    hnwExtQuery.AddField("MILPART");
    hnwExtQuery.AddField("MILFYMD");
    hnwExtQuery.AddField("MILTYMD");
    hnwExtQuery.AddField("HOBBY");
    hnwExtQuery.AddField("SKILL");
    hnwExtQuery.AddField("RELSEC");
    hnwExtQuery.AddField("SOCFYMD1");
    hnwExtQuery.AddField("SOCTYMD1");
    hnwExtQuery.AddField("SOCACT1");
    hnwExtQuery.AddField("SOCFELL1");
    hnwExtQuery.AddField("SOCFYMD2");
    hnwExtQuery.AddField("SOCTYMD2");
    hnwExtQuery.AddField("SOCACT2");
    hnwExtQuery.AddField("SOCFELL2");
    hnwExtQuery.AddField("CLUBNM1");
    hnwExtQuery.AddField("CLUBFOR1");
    hnwExtQuery.AddField("CLUB_OBJ1");
    hnwExtQuery.AddField("CLUBACT1");
    hnwExtQuery.AddField("CLUBNM2");
    hnwExtQuery.AddField("CLUBFOR2");
    hnwExtQuery.AddField("CLUB_OBJ2");
    hnwExtQuery.AddField("CLUBACT2");
    hnwExtQuery.AddField("TRAVELNM1");
    hnwExtQuery.AddField("TRAVELFYMD1");
    hnwExtQuery.AddField("TRAVELTYMD1");
    hnwExtQuery.AddField("TRAVELFOR1");
    hnwExtQuery.AddField("TRAVEL_RESULT1");
    hnwExtQuery.AddField("TRAVELNM2");
    hnwExtQuery.AddField("TRAVELFYMD2");
    hnwExtQuery.AddField("TRAVELTYMD2");
    hnwExtQuery.AddField("TRAVELFOR2");
    hnwExtQuery.AddField("TRAVEL_RESULT2");
    hnwExtQuery.AddField("MYSTRY");
    hnwExtQuery.AddField("MYCHAR");
    hnwExtQuery.AddField("MYINNO");
    hnwExtQuery.AddField("MYEMOT");
    hnwExtQuery.AddField("MYVISION");
    hnwExtQuery.AddField("COMCR");
    hnwExtQuery.AddField("SPLIT_FLAG");
    hnwExtQuery.AddField("PR_DATE");
    hnwExtQuery.AddField("PHOTO");
    hnwExtQuery.AddField("WPLACE");
    hnwExtQuery.AddField("DET_MAJOR");
    hnwExtQuery.AddField("PAPER");
    hnwExtQuery.AddField("HPLACE");
    hnwExtQuery.AddField("CPLACE");
    hnwExtQuery.AddField("EUPLACE");
    hnwExtQuery.AddField("UPLACE");
    hnwExtQuery.AddField("GSPLACE");
    hnwExtQuery.AddField("EUCGE");
    hnwExtQuery.AddField("UCGE");
    hnwExtQuery.AddField("GSCGE");
    hnwExtQuery.AddField("F_MAJOR");
    hnwExtQuery.AddField("S_MAJOR");
    hnwExtQuery.AddField("LICYMD1");
    hnwExtQuery.AddField("LICYMD2");
    hnwExtQuery.AddField("LICYMD3");


    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("REG_NO"));
            hnwExtQuery.AddData(vo.getString("REGAPP"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("NAM_ENG"));
            hnwExtQuery.AddData(vo.getString("NAM_CHI"));
            hnwExtQuery.AddData(vo.getString("JUMIN_NO"));
            hnwExtQuery.AddData(vo.getString("BIRYMD"));
            hnwExtQuery.AddData(vo.getString("BIRTAG"));
            hnwExtQuery.AddData(vo.getString("AGE"));
            hnwExtQuery.AddData(vo.getString("ORGADDR"));
            hnwExtQuery.AddData(vo.getString("WJOB1"));
            hnwExtQuery.AddData(vo.getString("WJOB2"));
            hnwExtQuery.AddData(vo.getString("WJOB3"));
            hnwExtQuery.AddData(vo.getString("HYM"));
            hnwExtQuery.AddData(vo.getString("HNAME"));
            hnwExtQuery.AddData(vo.getString("CYM"));
            hnwExtQuery.AddData(vo.getString("CNAME"));
            hnwExtQuery.AddData(vo.getString("CMAJOR"));
            hnwExtQuery.AddData(vo.getString("EUYM"));
            hnwExtQuery.AddData(vo.getString("EUNAME"));
            hnwExtQuery.AddData(vo.getString("EUMAJOR"));
            hnwExtQuery.AddData(vo.getString("EUSEC"));
            hnwExtQuery.AddData(vo.getString("UMYM"));
            hnwExtQuery.AddData(vo.getString("UNAME"));
            hnwExtQuery.AddData(vo.getString("UMAJOR"));
            hnwExtQuery.AddData(vo.getString("UGRDYN"));
            hnwExtQuery.AddData(vo.getString("GSYM"));
            hnwExtQuery.AddData(vo.getString("GSNAME1"));
            hnwExtQuery.AddData(vo.getString("GSNAME2"));
            hnwExtQuery.AddData(vo.getString("GSMAJOR1"));
            hnwExtQuery.AddData(vo.getString("GSMAJOR2"));
            hnwExtQuery.AddData(vo.getString("GSGRDYN"));
            hnwExtQuery.AddData(vo.getString("UAVE"));
            hnwExtQuery.AddData(vo.getString("GSAVE"));
            hnwExtQuery.AddData(vo.getString("UHAK"));
            hnwExtQuery.AddData(vo.getString("GSHAK"));
            hnwExtQuery.AddData(vo.getString("BDHEI"));
            hnwExtQuery.AddData(vo.getString("BDWEI"));
            hnwExtQuery.AddData(vo.getString("EYEL"));
            hnwExtQuery.AddData(vo.getString("EYER"));
            hnwExtQuery.AddData(vo.getString("C_EYEL"));
            hnwExtQuery.AddData(vo.getString("C_EYER"));
            hnwExtQuery.AddData(vo.getString("BLOOD"));
            hnwExtQuery.AddData(vo.getString("AWDYN"));
            hnwExtQuery.AddData(vo.getString("LIVE"));
            hnwExtQuery.AddData(vo.getString("MOVPOR"));
            hnwExtQuery.AddData(vo.getString("IMOVPOR"));
            hnwExtQuery.AddData(vo.getString("SIKUKN"));
            hnwExtQuery.AddData(vo.getString("ADDR"));
            hnwExtQuery.AddData(vo.getString("LPOST"));
            hnwExtQuery.AddData(vo.getString("RPOST"));
            hnwExtQuery.AddData(vo.getString("TEL1"));
            hnwExtQuery.AddData(vo.getString("TEL2"));
            hnwExtQuery.AddData(vo.getString("TEL3"));
            hnwExtQuery.AddData(vo.getString("HTEL1"));
            hnwExtQuery.AddData(vo.getString("HTEL2"));
            hnwExtQuery.AddData(vo.getString("HTEL3"));
            hnwExtQuery.AddData(vo.getString("EMAIL"));
            hnwExtQuery.AddData(vo.getString("LANGNM1"));
            hnwExtQuery.AddData(vo.getString("LANGLEV1"));
            hnwExtQuery.AddData(vo.getString("LANGNM2"));
            hnwExtQuery.AddData(vo.getString("LANGLEV2"));
            hnwExtQuery.AddData(vo.getString("LANGLEV2"));
            hnwExtQuery.AddData(vo.getString("LANGNM3"));
            hnwExtQuery.AddData(vo.getString("LANGLEV3"));
            hnwExtQuery.AddData(vo.getString("TOEIC"));
            hnwExtQuery.AddData(vo.getString("TOEFL"));
            hnwExtQuery.AddData(vo.getString("TESTNM"));
            hnwExtQuery.AddData(vo.getString("LANGJUM1"));
            hnwExtQuery.AddData(vo.getString("TESTNM2"));
            hnwExtQuery.AddData(vo.getString("LANGMAN2"));
            hnwExtQuery.AddData(vo.getString("LANGJUM2"));
            hnwExtQuery.AddData(vo.getString("TESTNM3"));
            hnwExtQuery.AddData(vo.getString("LANGMAN3"));
            hnwExtQuery.AddData(vo.getString("LANGJUM3"));
            hnwExtQuery.AddData(vo.getString("LICENCE1"));
            hnwExtQuery.AddData(vo.getString("LICENCE2"));
            hnwExtQuery.AddData(vo.getString("LICENCE3"));
            hnwExtQuery.AddData(vo.getString("AWDNM1"));
            hnwExtQuery.AddData(vo.getString("AWDCO1"));
            hnwExtQuery.AddData(vo.getString("AWDYMD1"));
            hnwExtQuery.AddData(vo.getString("AWDNM2"));
            hnwExtQuery.AddData(vo.getString("AWDCO2"));
            hnwExtQuery.AddData(vo.getString("AWDYMD2"));
            hnwExtQuery.AddData(vo.getString("AWDNM3"));
            hnwExtQuery.AddData(vo.getString("AWDCO3"));
            hnwExtQuery.AddData(vo.getString("AWDYMD3"));
            hnwExtQuery.AddData(vo.getString("PCTOOL1"));
            hnwExtQuery.AddData(vo.getString("PCABLE1"));
            hnwExtQuery.AddData(vo.getString("PCTOOL2"));
            hnwExtQuery.AddData(vo.getString("PCABLE2"));
            hnwExtQuery.AddData(vo.getString("PCTOOL3"));
            hnwExtQuery.AddData(vo.getString("PCABLE3"));
            hnwExtQuery.AddData(vo.getString("MILYN"));
            hnwExtQuery.AddData(vo.getString("MILFREE"));
            hnwExtQuery.AddData(vo.getString("MILSEC"));
            hnwExtQuery.AddData(vo.getString("MILGRD"));
            hnwExtQuery.AddData(vo.getString("MILPART"));
            hnwExtQuery.AddData(vo.getString("MILFYMD"));
            hnwExtQuery.AddData(vo.getString("MILTYMD"));
            hnwExtQuery.AddData(vo.getString("HOBBY"));
            hnwExtQuery.AddData(vo.getString("SKILL"));
            hnwExtQuery.AddData(vo.getString("RELSEC"));
            hnwExtQuery.AddData(vo.getString("SOCFYMD1"));
            hnwExtQuery.AddData(vo.getString("SOCTYMD1"));
            hnwExtQuery.AddData(vo.getString("SOCACT1"));
            hnwExtQuery.AddData(vo.getString("SOCFELL1"));
            hnwExtQuery.AddData(vo.getString("SOCFYMD2"));
            hnwExtQuery.AddData(vo.getString("SOCTYMD2"));
            hnwExtQuery.AddData(vo.getString("SOCACT2"));
            hnwExtQuery.AddData(vo.getString("SOCFELL2"));
            hnwExtQuery.AddData(vo.getString("CLUBNM1"));
            hnwExtQuery.AddData(vo.getString("CLUBFOR1"));
            hnwExtQuery.AddData(vo.getString("CLUB_OBJ1"));
            hnwExtQuery.AddData(vo.getString("CLUBACT1"));
            hnwExtQuery.AddData(vo.getString("CLUBNM2"));
            hnwExtQuery.AddData(vo.getString("CLUBFOR2"));
            hnwExtQuery.AddData(vo.getString("CLUB_OBJ2"));
            hnwExtQuery.AddData(vo.getString("CLUBACT2"));
            hnwExtQuery.AddData(vo.getString("TRAVELNM1"));
            hnwExtQuery.AddData(vo.getString("TRAVELFYMD1"));
            hnwExtQuery.AddData(vo.getString("TRAVELTYMD1"));
            hnwExtQuery.AddData(vo.getString("TRAVELFOR1"));
            hnwExtQuery.AddData(vo.getString("TRAVEL_RESULT1"));
            hnwExtQuery.AddData(vo.getString("TRAVELNM2"));
            hnwExtQuery.AddData(vo.getString("TRAVELFYMD2"));
            hnwExtQuery.AddData(vo.getString("TRAVELTYMD2"));
            hnwExtQuery.AddData(vo.getString("TRAVELFOR2"));
            hnwExtQuery.AddData(vo.getString("TRAVEL_RESULT2"));
            hnwExtQuery.AddData(vo.getString("MYSTRY"));
            hnwExtQuery.AddData(vo.getString("MYCHAR"));
            hnwExtQuery.AddData(vo.getString("MYINNO"));
            hnwExtQuery.AddData(vo.getString("MYEMOT"));
            hnwExtQuery.AddData(vo.getString("MYVISION"));
            hnwExtQuery.AddData(vo.getString("COMCR"));
            hnwExtQuery.AddData(vo.getString("SPLIT_FLAG"));
            hnwExtQuery.AddData(vo.getString("PR_DATE"));
            hnwExtQuery.AddData(vo.getString("PHOTO"));
            hnwExtQuery.AddData(vo.getString("WPLACE"));
            hnwExtQuery.AddData(vo.getString("DET_MAJOR"));
            hnwExtQuery.AddData(vo.getString("PAPER"));
            hnwExtQuery.AddData(vo.getString("HPLACE"));
            hnwExtQuery.AddData(vo.getString("CPLACE"));
            hnwExtQuery.AddData(vo.getString("EUPLACE"));
            hnwExtQuery.AddData(vo.getString("UPLACE"));
            hnwExtQuery.AddData(vo.getString("GSPLACE"));
            hnwExtQuery.AddData(vo.getString("EUCGE"));
            hnwExtQuery.AddData(vo.getString("UCGE"));
            hnwExtQuery.AddData(vo.getString("GSCGE"));
            hnwExtQuery.AddData(vo.getString("F_MAJOR"));
            hnwExtQuery.AddData(vo.getString("S_MAJOR"));
            hnwExtQuery.AddData(vo.getString("LICYMD1"));
            hnwExtQuery.AddData(vo.getString("LICYMD2"));
            hnwExtQuery.AddData(vo.getString("LICYMD3"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);
%>
