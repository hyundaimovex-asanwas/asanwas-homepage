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
	 * SCHA030DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SCHA030DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	
	/**
	 * ��������ó�� ���� ��� �λ���ǥ SELECT�� �����ϴ� DAO �޼ҵ�
	 */
	public void SCHA030_SHR_ACC(CBox p_box) throws CException {

		/** ���α׷� ��� �α� ������ ����Ѵ� **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESS_INS");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"HR",
				"scha030",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"S"
		};

		/** INSERT�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);		
		
	}		
	
	
	
	
	
	/**
	 * ���ڱ� ��û�� ó�� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void SCHA030_SHR(CBox p_box) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA030_SHR");

        String pay_yn = JSPUtil.rns(p_box.get("PAY_YN_SHR"));

		StringBuffer sb = new StringBuffer();

        //ó����Ȳ�� ������('I')�̸� ��û, �������� ������ �´�.
        if(pay_yn.equals("I"))
            sb.append("AND NVL(A.PAY_YN, '0') IN ('0', '1')\n");
        else
            sb.append("AND NVL(A.PAY_YN, '0') = NVL('"+pay_yn+"', NVL(A.PAY_YN, '0'))\n");

        String STR_YMD = JSPUtil.rns(p_box.get("STR_YMD")).replaceAll("-", "");
        String END_YMD = JSPUtil.rns(p_box.get("END_YMD")).replaceAll("-", "");
        String STR_YMD2 = JSPUtil.rns(p_box.get("STR_YMD2")).replaceAll("-", "");
        String END_YMD2 = JSPUtil.rns(p_box.get("END_YMD2")).replaceAll("-", "");

        //�˻���¥�� �˻��ϱ�
        if(!STR_YMD.equals(""))
            sb.append("AND TO_CHAR(A.IPT_YMD, 'YYYYMMDD') >= '"+STR_YMD+"'\n");
        if(!END_YMD.equals(""))
            sb.append("AND TO_CHAR(A.IPT_YMD, 'YYYYMMDD') <= '"+END_YMD+"'\n");

        if(!STR_YMD2.equals(""))
            sb.append("AND PAY_YMD >= '"+STR_YMD2+"'\n");
        if(!END_YMD2.equals(""))
            sb.append("AND PAY_YMD <= '"+END_YMD2+"'\n");


		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("DPT_CD_SHR")),
                JSPUtil.rns(p_box.get("ENO_NO_SHR"))
        };

		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ���ڱ� ��û���� �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void SCHA030_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA030_UPT");

		// �հ�
		int ret_amt = Integer.parseInt(JSPUtil.rns(vo.get("RET_AMT")));
		int edu_amt = Integer.parseInt(JSPUtil.rns(vo.get("EDU_AMT")));
		int end_amt = Integer.parseInt(JSPUtil.rns(vo.get("END_AMT")));
		int sco_amt = Integer.parseInt(JSPUtil.rns(vo.get("SCO_AMT")));
		String sum = ret_amt + edu_amt + end_amt + sco_amt +"";

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
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

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}



    /// ���� ��ǥ �߻��� ���Ѱ͵�.....
	/**
	 * ��ǥ �߻��� �ʿ��� �������� ������ ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet SCHA030_PRC_SHR_01(GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA030_PRC_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
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
	 * ���翡 �ʿ��� �������� ������ ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet SCHA030_PRC_SHR_PRINT(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA030_PRC_SHR_PRINT");



		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("SESSION_DPTCD")),
				JSPUtil.rns(p_box.get("SESSION_DPTCD"))
        };

		return this.selectProcess(sql, bind, prop);
	}

	/**
	 * ���翡 �ʿ��� �������� ������ ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet SCHA030_PRC_SHR_03(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA030_PRC_SHR_03");


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("FILE_KEY"))
        };

		return this.selectProcess(sql, bind, prop);
	}
	/**
     * �����ݽ�ûTable�� �����ݽ�û���� Update DAO �޼���
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void SCHA010_PRC_UPT_02(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA010_PRC_UPT_02");

		/** �˻� ���� Mapping(PrepareStatement ) **/
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

		/** DELETE�޼ҵ� ȣ��  **/
		this.updateProcess(sql, bind);

	}

	/**
     * �����ݽ�ûTable�� �����ݽ�û���� Update DAO �޼���
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void SCHA030_PRC_UPT_01(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA030_PRC_UPT_01");

		/** �˻� ���� Mapping(PrepareStatement ) **/
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

		/** DELETE�޼ҵ� ȣ��  **/
		this.updateProcess(sql, bind);

	}
	/**
	 * ���ڱ� ��û��ȣ ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet SCHA030_PRC_SHR_REQ(GauceValueObject vo, CBox p_box) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA030_PRC_SHR_REQ");


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

        };
		prop.add("REQ_NO", ColumnProp.COLUMN_TYPE_STRING, 20, ColumnProp.CONSTRAINT_TB_NORMAL);
		return this.selectProcess(sql, bind, prop);
	}


	/**
     * ��ǥ�߻��ÿ� ������� html
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void SCHA030_PRC_MAKE_HTML(CBox p_box,GauceDataSet ds, GauceDataSet dsFile) throws CException {
		//0:��û,1:����,2:�ݼ�,3:����
		String PAY_YN = GauceUtils.nameValue(ds, 1, "PAY_YN");
		String PAY_YN_NM = "";
		if("0".equals(PAY_YN)){
			PAY_YN_NM = "��û";
		}else if("1".equals(PAY_YN)){
			PAY_YN_NM = "����";
		}else if("2".equals(PAY_YN)){
			PAY_YN_NM = "�ݼ�";
		}else if("3".equals(PAY_YN)){
			PAY_YN_NM = "��ǥ";
		}else if("4".equals(PAY_YN)){
			PAY_YN_NM = "����";
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
		content.append(" 	<title>���ڱ� ��û�� ó��(scha030)</title>                                                                                                                                  \n");
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
		content.append("            // ÷�� ������ �����ϴ� ��츸 �����ϰ�~  \n");
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
		content.append("             <td align='center' class='creamBold'>�Ҽ�</td>                                                                                                                   \n");
		content.append("             <td class='padding2423'>").append(DPT_NM).append("</td>                                                                                                                                                            \n");
		content.append("             <td align='center' class='creamBold'>����</td>                                                                                                                   \n");
		content.append("             <td class='padding2423' colspan='3'>").append(JOB_NM).append("</td>                                                                                                                                                            \n");
		content.append("             <td align='center' class='creamBold'>���</td>                                                                                                                   \n");
		content.append("             <td class='padding2423'>").append(ENO_NO).append("</td>           \n");
		content.append("             <td align='center' class='creamBold'>����</td>                                                                                                                   \n");
		content.append("             <td class='padding2423'>").append(ENO_NM).append("</td>                                                                    \n");
		content.append("             <td align='center' class='creamBold'>�Ի���</td>                                                                                                                 \n");
		content.append("             <td class='padding2423'>").append(HIR_YMD).append("</td>                                                     \n");
		content.append("         </tr>                                                                                                                                                                \n");
		content.append("         </table>                                                                                                                                                             \n");
		content.append("         </td>                                                                                                                                                                \n");
		content.append("     </tr>                                                                                                                                                                    \n");
		content.append("     <tr>                                                                                                                                                                     \n");
		content.append("         <td>                                                                                                                                                                 \n");
		content.append("             <table width='800' border='0' cellspacing='0' cellpadding='0'>                                                                                                   \n");
		content.append("                 <tr>                                                                                                                                                         \n");
		content.append("                     <td align='left' class='paddingTop8'><img src='/images/specialHr/dotGreen.gif' width='10' height='10' align='absmiddle'> �����ڳ࿡ ���� ����</td>       \n");
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
		content.append("             <td align='center' class='creamBold'>�б���</td>                                                                                                                 \n");
		content.append("             <td class='padding2423'>").append(SCH_NM).append("</td>                                                                    \n");
		content.append("             <td align='center' class='creamBold'>�а�</td>                                                                                                                   \n");
		content.append("             <td class='padding2423'>").append(MAJ_NM).append("</td>                                                                    \n");
		content.append("             <td align='center' class='creamBold'>�г�</td>                                                                                                                   \n");
		content.append("             <td class='padding2423'>").append(FSCH_NM).append("</td>                                                                   \n");
		content.append("             <td align='center' class='creamBold'>���޳��</td>                                                                                                               \n");
		content.append("             <td class='padding2423'>").append(PIS_YM).append("</td>                                                                                                                                                            \n");
		content.append("             <td align='center' class='creamBold'>��������</td>                                                                                                               \n");
		content.append("             <td class='padding2423'>").append(PAY_YMD).append("</td>                                                                                                                                                            \n");
		content.append("         </tr>                                                                                                                                                                \n");
		content.append("         <tr>                                                                                                                                                                 \n");
		content.append("             <td align='center' class='creamBold'>����</td>                                                                                                                   \n");
		content.append("             <td class='padding2423'>").append(SEL_NM).append("</td>                                                                    \n");
		content.append("             <td align='center' class='creamBold'>�ֹι�ȣ</td>                                                                                                               \n");
		content.append("             <td class='padding2423'>").append(BIR_YMD).append("</td>                                                                    \n");
		content.append("             <td align='center' class='creamBold' rowspan='4'>���⼭��<br>÷��</td>                                                                                           \n");
		content.append("             <td class='padding2423' colspan='5'  rowspan='4' align='right' valign='top'>                                                                                     \n");
		content.append(" 				<table width='100%' border='1' cellspacing='0' cellpadding='0' style='border-collapse: collapse' bordercolor='#999999' class='table_cream'>	                          \n");
		content.append(" 					<tr >                                                                                                                                                               \n");
		content.append(" 					<th width='30' class='creamBold'>NO</th>                                                                                                                            \n");
		content.append(" 					<th class='creamBold'>���ϸ�</th>                                                                                                                                   \n");
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
		content.append("             <td align='center' class='creamBold'>���б�</td>                                                                                                                 \n");
		content.append("             <td class='padding2423'>                                                                                                                                         \n");
		content.append("                 <table width='100%' border='0' >                                                                                                                             \n");
		content.append("                 <tr>                                                                                                                                                         \n");
		content.append("                     <td width='90%'>").append(RET_AMT).append("</td>                                                                                                                                                    \n");
		content.append("                     <td align='left'>��</td>                                                                                                                                 \n");
		content.append("                 </tr>                                                                                                                                                        \n");
		content.append("                 </table>                                                                                                                                                     \n");
		content.append("             </td>                                                                                                                                                            \n");
		content.append("             <td align='center' class='creamBold'>������</td>                                                                                                                 \n");
		content.append("             <td class='padding2423'>                                                                                                                                         \n");
		content.append("                 <table width='100%' border='0' >                                                                                                                             \n");
		content.append("                     <tr>                                                                                                                                                     \n");
		content.append("                     <td width='90%'>").append(EDU_AMT).append("</td>                                                                                                                                                    \n");
		content.append("                     <td align='left'>��</td>                                                                                                                                 \n");
		content.append("                     </tr>                                                                                                                                                    \n");
		content.append("                 </table>                                                                                                                                                     \n");
		content.append("             </td>                                                                                                                                                            \n");
		content.append("         </tr>                                                                                                                                                                \n");
		content.append("         <tr>                                                                                                                                                                 \n");
		content.append("             <td align='center' class='creamBold'>�⼺ȸ��</td>                                                                                                               \n");
		content.append("             <td class='padding2423'>                                                                                                                                         \n");
		content.append("                 <table width='100%' border='0' >                                                                                                                             \n");
		content.append("                     <tr>                                                                                                                                                     \n");
		content.append("                     <td width='90%'>").append(END_AMT).append("</td>                                                                                                                                                    \n");
		content.append("                     <td align='left'>��</td>                                                                                                                                 \n");
		content.append("                     </tr>                                                                                                                                                    \n");
		content.append("                 </table>                                                                                                                                                     \n");
		content.append("             </td>                                                                                                                                                            \n");
		content.append("             <td align='center' class='creamBold'>��</td>                                                                                                                     \n");
		content.append("             <td class='padding2423'>                                                                                                                                         \n");
		content.append("                 <table width='100%' border='0' >                                                                                                                             \n");
		content.append("                 <tr>                                                                                                                                                         \n");
		content.append("                     <td width='90%'>").append(TOT_AMT).append("</td>                                                                                                                                                    \n");
		content.append("                     <td align='left'>��</td>                                                                                                                                 \n");
		content.append("                 </tr>                                                                                                                                                        \n");
		content.append("                 </table>                                                                                                                                                     \n");
		content.append("             </td>                                                                                                                                                            \n");
		content.append("         </tr>                                                                                                                                                                \n");
		content.append("         <tr>                                                                                                                                                                 \n");
		content.append("             <td align='center' class='creamBold'>���ޱݾ�</td>                                                                                                               \n");
		content.append("             <td class='padding2423'>                                                                                                                                         \n");
		content.append("                 <table width='100%' border='0' >                                                                                                                             \n");
		content.append("                 <tr>                                                                                                                                                         \n");
		content.append("                     <td width='85px'>").append(PAY_AMT).append("</td>                                                                                                                                                    \n");
		content.append("                     <td align='left'>��</td>                                                                                                                                 \n");
		content.append("                 </tr>                                                                                                                                                        \n");
		content.append("                 </table>                                                                                                                                                     \n");
		content.append("             </td>                                                                                                                                                            \n");
		content.append("             <td align='center' class='creamBold'>���޿���</td>                                                                                                               \n");
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
