package Ehr.sch.a.scha030.dao;

import java.io.FileOutputStream;
import java.io.IOException;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.CommUtil;
import Ehr.common.util.JSPUtil;

public class SCHA030DAO extends AbstractDAO {
	/**
	 * SCHA030DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SCHA030DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	
	/**
	 * 개인정보처리 접속 기록 인사기록표 SELECT를 수행하는 DAO 메소드
	 */
	public void SCHA030_SHR_ACC(CBox p_box) throws CException {

		/** 프로그램 사용 로그 정보를 기록한다 **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESS_INS");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"HR",
				"scha030",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"S"
		};

		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);		
		
	}		
	
	
	
	
	
	/**
	 * 학자금 신청서 처리 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void SCHA030_SHR(CBox p_box) throws CException {
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA030_SHR");

        String pay_yn = JSPUtil.rns(p_box.get("PAY_YN_SHR"));

		StringBuffer sb = new StringBuffer();

        //처리현황이 진행중('I')이면 신청, 접수건을 가지고 온다.
        if(pay_yn.equals("I"))
            sb.append("AND NVL(A.PAY_YN, '0') IN ('0', '1')\n");
        else
            sb.append("AND NVL(A.PAY_YN, '0') = NVL('"+pay_yn+"', NVL(A.PAY_YN, '0'))\n");

        String STR_YMD = JSPUtil.rns(p_box.get("STR_YMD")).replaceAll("-", "");
        String END_YMD = JSPUtil.rns(p_box.get("END_YMD")).replaceAll("-", "");
        String STR_YMD2 = JSPUtil.rns(p_box.get("STR_YMD2")).replaceAll("-", "");
        String END_YMD2 = JSPUtil.rns(p_box.get("END_YMD2")).replaceAll("-", "");

        //검색날짜로 검색하기
        if(!STR_YMD.equals(""))
            sb.append("AND TO_CHAR(A.IPT_YMD, 'YYYYMMDD') >= '"+STR_YMD+"'\n");
        if(!END_YMD.equals(""))
            sb.append("AND TO_CHAR(A.IPT_YMD, 'YYYYMMDD') <= '"+END_YMD+"'\n");

        if(!STR_YMD2.equals(""))
            sb.append("AND PAY_YMD >= '"+STR_YMD2+"'\n");
        if(!END_YMD2.equals(""))
            sb.append("AND PAY_YMD <= '"+END_YMD2+"'\n");


		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("DPT_CD_SHR")),
                JSPUtil.rns(p_box.get("ENO_NO_SHR"))
        };

		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 학자금 신청서를 수정하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void SCHA030_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA030_UPT");

		// 합계
		int ret_amt = Integer.parseInt(JSPUtil.rns(vo.get("RET_AMT")));
		int edu_amt = Integer.parseInt(JSPUtil.rns(vo.get("EDU_AMT")));
		int end_amt = Integer.parseInt(JSPUtil.rns(vo.get("END_AMT")));
		int sco_amt = Integer.parseInt(JSPUtil.rns(vo.get("SCO_AMT")));
		String sum = ret_amt + edu_amt + end_amt + sco_amt +"";

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("RET_AMT")),
				JSPUtil.rns(vo.get("EDU_AMT")),
				JSPUtil.rns(vo.get("END_AMT")),
				JSPUtil.rns(vo.get("SCO_AMT")),
				sum, // (TOT_AMT)
                JSPUtil.rns(vo.get("PAY_AMT")),
                JSPUtil.rns(vo.get("PAY_YN")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(vo.get("IOC_GBN")),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("PIS_YY")),
				JSPUtil.rns(vo.get("PIS_MM")),
				JSPUtil.rns(vo.get("BIR_YMD").replaceAll("-", "")),
				JSPUtil.rns(vo.get("SEL_NM"))
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}



    /// 이하 전표 발생에 관한것들.....
	/**
	 * 전표 발생에 필요한 변수값을 가져옴 조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet SCHA030_PRC_SHR_01(GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA030_PRC_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
                JSPUtil.rns(vo.get("IOC_GBN")),
                JSPUtil.rns(vo.get("ENO_NO")),
                JSPUtil.rns(vo.get("PIS_YY")),
                JSPUtil.rns(vo.get("PIS_MM")),
                JSPUtil.rns(vo.get("BIR_YMD").replaceAll("-", "")),
                JSPUtil.rns(vo.get("SEL_NM"))
        };
		prop.add("TAX_DPT_CD", ColumnProp.COLUMN_TYPE_STRING, 20, ColumnProp.CONSTRAINT_TB_NORMAL);
		return this.selectProcess(sql, bind, prop);
	}
	/**
	 * 결재에 필요한 변수값을 가져옴 조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet SCHA030_PRC_SHR_PRINT(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA030_PRC_SHR_PRINT");



		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("SESSION_DPTCD")),
				JSPUtil.rns(p_box.get("SESSION_DPTCD"))
        };

		return this.selectProcess(sql, bind, prop);
	}

	/**
	 * 결재에 필요한 변수값을 가져옴 조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet SCHA030_PRC_SHR_03(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA030_PRC_SHR_03");


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("FILE_KEY"))
        };

		return this.selectProcess(sql, bind, prop);
	}
	/**
     * 경조금신청Table에 경조금신청정보 Update DAO 메서드
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void SCHA010_PRC_UPT_02(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA010_PRC_UPT_02");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("PRINT_NO")),
				JSPUtil.rns(p_box.get("vusrid")),

				JSPUtil.rns(vo.get("IOC_GBN")),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("PIS_YY")),
				JSPUtil.rns(vo.get("PIS_MM")),
				JSPUtil.rns(vo.get("BIR_YMD").replaceAll("-", "")),
				JSPUtil.rns(vo.get("SEL_NM"))
		};

		/** DELETE메소드 호출  **/
		this.updateProcess(sql, bind);

	}

	/**
     * 경조금신청Table에 경조금신청정보 Update DAO 메서드
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void SCHA030_PRC_UPT_01(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA030_PRC_UPT_01");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO"),
				p_box.get("REQ_NO"),
				p_box.get("vusrid"),

				JSPUtil.rns(vo.get("IOC_GBN")),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("PIS_YY")),
				JSPUtil.rns(vo.get("PIS_MM")),
				JSPUtil.rns(vo.get("BIR_YMD").replaceAll("-", "")),
				JSPUtil.rns(vo.get("SEL_NM"))
		};

		/** DELETE메소드 호출  **/
		this.updateProcess(sql, bind);

	}
	/**
	 * 학자금 신청번호 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet SCHA030_PRC_SHR_REQ(GauceValueObject vo, CBox p_box) throws CException {
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA030_PRC_SHR_REQ");


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

        };
		prop.add("REQ_NO", ColumnProp.COLUMN_TYPE_STRING, 20, ColumnProp.CONSTRAINT_TB_NORMAL);
		return this.selectProcess(sql, bind, prop);
	}


	/**
     * 전표발생시에 만들어줄 html
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void SCHA030_PRC_MAKE_HTML(CBox p_box,GauceDataSet ds, GauceDataSet dsFile) throws CException {
		//0:신청,1:접수,2:반송,3:지급
		String PAY_YN = GauceUtils.nameValue(ds, 1, "PAY_YN");
		String PAY_YN_NM = "";
		if("0".equals(PAY_YN)){
			PAY_YN_NM = "신청";
		}else if("1".equals(PAY_YN)){
			PAY_YN_NM = "접수";
		}else if("2".equals(PAY_YN)){
			PAY_YN_NM = "반송";
		}else if("3".equals(PAY_YN)){
			PAY_YN_NM = "전표";
		}else if("4".equals(PAY_YN)){
			PAY_YN_NM = "지급";
		}
		String DPT_NM = GauceUtils.nameValue(ds, 1, "DPT_NM");
		String JOB_NM = GauceUtils.nameValue(ds, 1, "JOB_NM");
		String ENO_NM = GauceUtils.nameValue(ds, 1, "ENO_NM");
		String ENO_NO = GauceUtils.nameValue(ds, 1, "ENO_NO");
		String HIR_YMD = GauceUtils.nameValue(ds, 1, "HIR_YMD");
		String SCH_NM = GauceUtils.nameValue(ds, 1, "SCH_NM");
		String MAJ_NM = JSPUtil.rns(GauceUtils.nameValue(ds, 1, "MAJ_NM"));
		String FSCH_NM = GauceUtils.nameValue(ds, 1, "FSCH_NM");
		String PIS_YM = GauceUtils.nameValue(ds, 1, "PIS_YM");
		String PAY_YMD = GauceUtils.nameValue(ds, 1, "PAY_YMD");
		String SEL_NM = GauceUtils.nameValue(ds, 1, "SEL_NM");
		String BIR_YMD = GauceUtils.nameValue(ds, 1, "BIR_YMD");
		String RET_AMT = JSPUtil.getMFormat(GauceUtils.nameValue(ds, 1, "RET_AMT"));
		String EDU_AMT = JSPUtil.getMFormat(GauceUtils.nameValue(ds, 1, "EDU_AMT"));
		String END_AMT = JSPUtil.getMFormat(GauceUtils.nameValue(ds, 1, "END_AMT"));
		String SCO_AMT = JSPUtil.getMFormat(GauceUtils.nameValue(ds, 1, "SCO_AMT"));
		String TOT_AMT = JSPUtil.getMFormat(GauceUtils.nameValue(ds, 1, "TOT_AMT"));
		String PAY_AMT = JSPUtil.getMFormat(GauceUtils.nameValue(ds, 1, "PAY_AMT"));
		String FILE_NAME       = GauceUtils.nameValue(ds, 1, "FILE_NAME");
		StringBuffer content = new StringBuffer();


		content.append(" <html>                                                                                                                                            														\n");
		content.append(" <head>                                                                                                                                                                       \n");
		content.append(" 	<title>학자금 신청서 처리(scha030)</title>                                                                                                                                  \n");
		content.append(" 	<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>                                                                                                        \n");
		content.append(" 	<link href='/css/style.css' rel='stylesheet' type='text/css'>                                                                                                               \n");
		content.append(" 	<link href='/css/general.css' rel='stylesheet' type='text/css'>                                                                                                             \n");
		content.append(" 	<script language=javascript src='/common/common.js'></script>                                                                                                               \n");
		content.append(" 	<script language=javascript src='/common/input.js'></script>                                                                                                                \n");
		content.append(" 	<script language=javascript src='/common/mdi_common.js'></script>                                                                                                           \n");
		content.append(" 	<script language='javascript' src='/common/calendar/calendar.js'></script>                                                                                                  \n");
		content.append("	<SCRIPT LANGUAGE='JavaScript'>											\n");
		content.append("	<!--                                                \n");
		content.append("	function fnc_FileDownload(vFILE_NAME, vFILE_URL){   \n");
		content.append("            // 첨부 파일이 존재하는 경우만 수행하게~  \n");
		content.append("            if (vFILE_NAME != '' && vFILE_URL != '') {\n");
		content.append("                cfDownload(vFILE_NAME, vFILE_URL);    \n");
		content.append("            }                                         \n");
		content.append("	}                                                   \n");
		content.append("	//-->                                               \n");
		content.append("	</SCRIPT>                                           \n");
		content.append(" <body leftmargin='20' topmargin='14' rightmargin='20' bottommargin='15' marginwidth='0' marginheight='0' scroll='auto'>                                                      \n");
		content.append("     <table width='800' border='0' cellspacing='0' cellpadding='0'>                                                                                                           \n");
		content.append("     <tr>                                                                                                                                                                     \n");
		content.append("         <td class='paddingTop8'>                                                                                                                                             \n");
		content.append("         <table width='100%' border='1' cellspacing='0' cellpadding='0' style='border-collapse: collapse' bordercolor='#999999' class='table_cream'>                          \n");
		content.append("         <colgroup>                                                                                                                                                           \n");
		content.append("             <col width='60'></col>                                                                                                                                           \n");
		content.append("             <col width='110'></col>                                                                                                                                          \n");
		content.append("             <col width='60'></col>                                                                                                                                           \n");
		content.append("             <col width='60'></col>                                                                                                                                           \n");
		content.append("             <col width='60'></col>                                                                                                                                           \n");
		content.append("             <col width='90'></col>                                                                                                                                           \n");
		content.append("             <col width='60'></col>                                                                                                                                           \n");
		content.append("             <col width='70'></col>                                                                                                                                           \n");
		content.append("             <col width='60'></col>                                                                                                                                           \n");
		content.append("             <col width='*'></col>                                                                                                                                            \n");
		content.append("         </colgroup>                                                                                                                                                          \n");
		content.append("         <tr>                                                                                                                                                                 \n");
		content.append("             <td align='center' class='creamBold'>소속</td>                                                                                                                   \n");
		content.append("             <td class='padding2423'>").append(DPT_NM).append("</td>                                                                                                                                                            \n");
		content.append("             <td align='center' class='creamBold'>직위</td>                                                                                                                   \n");
		content.append("             <td class='padding2423' colspan='3'>").append(JOB_NM).append("</td>                                                                                                                                                            \n");
		content.append("             <td align='center' class='creamBold'>사번</td>                                                                                                                   \n");
		content.append("             <td class='padding2423'>").append(ENO_NO).append("</td>           \n");
		content.append("             <td align='center' class='creamBold'>성명</td>                                                                                                                   \n");
		content.append("             <td class='padding2423'>").append(ENO_NM).append("</td>                                                                    \n");
		content.append("             <td align='center' class='creamBold'>입사일</td>                                                                                                                 \n");
		content.append("             <td class='padding2423'>").append(HIR_YMD).append("</td>                                                     \n");
		content.append("         </tr>                                                                                                                                                                \n");
		content.append("         </table>                                                                                                                                                             \n");
		content.append("         </td>                                                                                                                                                                \n");
		content.append("     </tr>                                                                                                                                                                    \n");
		content.append("     <tr>                                                                                                                                                                     \n");
		content.append("         <td>                                                                                                                                                                 \n");
		content.append("             <table width='800' border='0' cellspacing='0' cellpadding='0'>                                                                                                   \n");
		content.append("                 <tr>                                                                                                                                                         \n");
		content.append("                     <td align='left' class='paddingTop8'><img src='/images/specialHr/dotGreen.gif' width='10' height='10' align='absmiddle'> 수혜자녀에 대한 정보</td>       \n");
		content.append("                     <td align='right' style='padding-top:5px; padding-bottom:5px;'>                                                                                          \n");
		content.append("                         &nbsp;                                                                                                                                               \n");
		content.append("                     </td>                                                                                                                                                    \n");
		content.append("                 </tr>                                                                                                                                                        \n");
		content.append("             </table>                                                                                                                                                         \n");
		content.append("         </td>                                                                                                                                                                \n");
		content.append("     </tr>                                                                                                                                                                    \n");
		content.append("     <tr>                                                                                                                                                                     \n");
		content.append("         <td>                                                                                                                                                                 \n");
		content.append("         <table width='100%' border='1' cellspacing='0' cellpadding='0' style='border-collapse: collapse' bordercolor='#999999' class='table_cream'>                          \n");
		content.append("         <colgroup>                                                                                                                                                           \n");
		content.append(" 			<col width='70'></col>                                                                                                                                            \n");
		content.append(" 			<col width='110'></col>                                                                                                                                           \n");
		content.append(" 			<col width='70'></col>                                                                                                                                            \n");
		content.append(" 			<col width='110'></col>                                                                                                                                           \n");
		content.append("                                                                                                                                                                              \n");
		content.append(" 			<col width='70'></col>                                                                                                                                            \n");
		content.append(" 			<col width='70'></col>                                                                                                                                            \n");
		content.append(" 			<col width='60'></col>                                                                                                                                            \n");
		content.append(" 			<col width='50'></col>                                                                                                                                            \n");
		content.append(" 			<col width='60'></col>                                                                                                                                            \n");
		content.append(" 			<col width='*'></col>                                                                                                                                             \n");
		content.append("         </colgroup>                                                                                                                                                          \n");
		content.append("         <tr>                                                                                                                                                                 \n");
		content.append("             <td align='center' class='creamBold'>학교명</td>                                                                                                                 \n");
		content.append("             <td class='padding2423'>").append(SCH_NM).append("</td>                                                                    \n");
		content.append("             <td align='center' class='creamBold'>학과</td>                                                                                                                   \n");
		content.append("             <td class='padding2423'>").append(MAJ_NM).append("</td>                                                                    \n");
		content.append("             <td align='center' class='creamBold'>학년</td>                                                                                                                   \n");
		content.append("             <td class='padding2423'>").append(FSCH_NM).append("</td>                                                                   \n");
		content.append("             <td align='center' class='creamBold'>지급년월</td>                                                                                                               \n");
		content.append("             <td class='padding2423'>").append(PIS_YM).append("</td>                                                                                                                                                            \n");
		content.append("             <td align='center' class='creamBold'>지급일자</td>                                                                                                               \n");
		content.append("             <td class='padding2423'>").append(PAY_YMD).append("</td>                                                                                                                                                            \n");
		content.append("         </tr>                                                                                                                                                                \n");
		content.append("         <tr>                                                                                                                                                                 \n");
		content.append("             <td align='center' class='creamBold'>성명</td>                                                                                                                   \n");
		content.append("             <td class='padding2423'>").append(SEL_NM).append("</td>                                                                    \n");
		content.append("             <td align='center' class='creamBold'>주민번호</td>                                                                                                               \n");
		content.append("             <td class='padding2423'>").append(BIR_YMD).append("</td>                                                                    \n");
		content.append("             <td align='center' class='creamBold' rowspan='4'>제출서류<br>첨부</td>                                                                                           \n");
		content.append("             <td class='padding2423' colspan='5'  rowspan='4' align='right' valign='top'>                                                                                     \n");
		content.append(" 				<table width='100%' border='1' cellspacing='0' cellpadding='0' style='border-collapse: collapse' bordercolor='#999999' class='table_cream'>	                          \n");
		content.append(" 					<tr >                                                                                                                                                               \n");
		content.append(" 					<th width='30' class='creamBold'>NO</th>                                                                                                                            \n");
		content.append(" 					<th class='creamBold'>파일명</th>                                                                                                                                   \n");
		content.append(" 					</tr>                                                                                                                                                               \n");
		String str = "<tr onClick=\"fnc_FileDownload('";
		String end = "')\"  style='cursor:hand'>";
		for(int i = 1; i <= dsFile.getDataRowCnt(); i ++){
			String fileName = GauceUtils.nameValue(dsFile, i, "FILE_NAME");
			String fileURL  = GauceUtils.nameValue(dsFile, i, "FILE_URL");

			content.append(str).append(fileName).append("', '").append(fileURL).append(end).append("                                                         \n");
			content.append(" 					<td>").append(i).append("</th>                                                                                                                                                          \n");
			content.append(" 					<td>").append(fileName).append("</td>                                                                                                                                                  \n");
			content.append(" 					</tr>                                                                                                                                                               \n");
		}

		content.append(" 				</table>                                                                                                                                                              \n");
		content.append("             </td>                                                                                                                                                            \n");
		content.append("         </tr>                                                                                                                                                                \n");
		content.append("         <tr>                                                                                                                                                                 \n");
		content.append("             <td align='center' class='creamBold'>입학금</td>                                                                                                                 \n");
		content.append("             <td class='padding2423'>                                                                                                                                         \n");
		content.append("                 <table width='100%' border='0' >                                                                                                                             \n");
		content.append("                 <tr>                                                                                                                                                         \n");
		content.append("                     <td width='90%'>").append(RET_AMT).append("</td>                                                                                                                                                    \n");
		content.append("                     <td align='left'>원</td>                                                                                                                                 \n");
		content.append("                 </tr>                                                                                                                                                        \n");
		content.append("                 </table>                                                                                                                                                     \n");
		content.append("             </td>                                                                                                                                                            \n");
		content.append("             <td align='center' class='creamBold'>수업료</td>                                                                                                                 \n");
		content.append("             <td class='padding2423'>                                                                                                                                         \n");
		content.append("                 <table width='100%' border='0' >                                                                                                                             \n");
		content.append("                     <tr>                                                                                                                                                     \n");
		content.append("                     <td width='90%'>").append(EDU_AMT).append("</td>                                                                                                                                                    \n");
		content.append("                     <td align='left'>원</td>                                                                                                                                 \n");
		content.append("                     </tr>                                                                                                                                                    \n");
		content.append("                 </table>                                                                                                                                                     \n");
		content.append("             </td>                                                                                                                                                            \n");
		content.append("         </tr>                                                                                                                                                                \n");
		content.append("         <tr>                                                                                                                                                                 \n");
		content.append("             <td align='center' class='creamBold'>기성회비</td>                                                                                                               \n");
		content.append("             <td class='padding2423'>                                                                                                                                         \n");
		content.append("                 <table width='100%' border='0' >                                                                                                                             \n");
		content.append("                     <tr>                                                                                                                                                     \n");
		content.append("                     <td width='90%'>").append(END_AMT).append("</td>                                                                                                                                                    \n");
		content.append("                     <td align='left'>원</td>                                                                                                                                 \n");
		content.append("                     </tr>                                                                                                                                                    \n");
		content.append("                 </table>                                                                                                                                                     \n");
		content.append("             </td>                                                                                                                                                            \n");
		content.append("             <td align='center' class='creamBold'>계</td>                                                                                                                     \n");
		content.append("             <td class='padding2423'>                                                                                                                                         \n");
		content.append("                 <table width='100%' border='0' >                                                                                                                             \n");
		content.append("                 <tr>                                                                                                                                                         \n");
		content.append("                     <td width='90%'>").append(TOT_AMT).append("</td>                                                                                                                                                    \n");
		content.append("                     <td align='left'>원</td>                                                                                                                                 \n");
		content.append("                 </tr>                                                                                                                                                        \n");
		content.append("                 </table>                                                                                                                                                     \n");
		content.append("             </td>                                                                                                                                                            \n");
		content.append("         </tr>                                                                                                                                                                \n");
		content.append("         <tr>                                                                                                                                                                 \n");
		content.append("             <td align='center' class='creamBold'>지급금액</td>                                                                                                               \n");
		content.append("             <td class='padding2423'>                                                                                                                                         \n");
		content.append("                 <table width='100%' border='0' >                                                                                                                             \n");
		content.append("                 <tr>                                                                                                                                                         \n");
		content.append("                     <td width='85px'>").append(PAY_AMT).append("</td>                                                                                                                                                    \n");
		content.append("                     <td align='left'>원</td>                                                                                                                                 \n");
		content.append("                 </tr>                                                                                                                                                        \n");
		content.append("                 </table>                                                                                                                                                     \n");
		content.append("             </td>                                                                                                                                                            \n");
		content.append("             <td align='center' class='creamBold'>지급여부</td>                                                                                                               \n");
		content.append("             <td class='padding2423'>").append(PAY_YN_NM).append("</td>                                                                                                                                                            \n");
		content.append("         </tr>                                                                                                                                                                \n");
		content.append("         </table>                                                                                                                                                             \n");
		content.append("         </td>                                                                                                                                                                \n");
		content.append("     </tr>                                                                                                                                                                    \n");
		content.append("     </table>                                                                                                                                                                 \n");
		content.append(" 	</form>                                                                                                                                                                     \n");
		content.append(" </body>                                                                                                                                                                      \n");
		content.append(" </html>                                                                                                                                                                      \n");

		try{
			FileOutputStream fos = new FileOutputStream(CommUtil.getHtmlFilePath()+FILE_NAME+".html");
			fos.write(content.toString().getBytes());
			fos.close();
		}catch(IOException e){
			e.printStackTrace();
		}

	}
}
