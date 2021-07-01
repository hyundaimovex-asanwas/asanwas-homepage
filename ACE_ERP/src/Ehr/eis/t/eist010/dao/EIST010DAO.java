package Ehr.eis.t.eist010.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EIST010DAO extends AbstractDAO {
	/**
	 * PIRA060DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EIST010DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}
	
	/**
	 * SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EIST010_SHR(CBox p_box, String SEQ) throws CException {
		
		/** �ܺ� XML���� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST010_SHR");
		
		/** ��ģ ������ ���� ó�� #1 **/
		StringBuffer sb = new StringBuffer();

		if (SEQ.equals("1")) {
			
			sb.append("UNION ALL 																										\n");
			sb.append(" SELECT B.COST_CD AS PJT_CD,B.PLJ_NM AS PJT_NM,																	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_01,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_02,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_03,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_04,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_05,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_06,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_07,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_08,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_09,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_10,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_11,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_12,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_13,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_14,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_15,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_16,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_17,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_18,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_19,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_20,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_21,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_22,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_23,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_24,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_25,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_26,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_27,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_28,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_29,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_30,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'0') AS DAY_31,	\n");			

			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'),'9') AS YOIL_01,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"'),'9') AS YOIL_02,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"'),'9') AS YOIL_03,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"'),'9') AS YOIL_04,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"'),'9') AS YOIL_05,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"'),'9') AS YOIL_06,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"'),'9') AS YOIL_07,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"'),'9') AS YOIL_08,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"'),'9') AS YOIL_09,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"'),'9') AS YOIL_10,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"'),'9') AS YOIL_11,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"'),'9') AS YOIL_12,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"'),'9') AS YOIL_13,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"'),'9') AS YOIL_14,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"'),'9') AS YOIL_15,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"'),'9') AS YOIL_16,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"'),'9') AS YOIL_17,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"'),'9') AS YOIL_18,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"'),'9') AS YOIL_19,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"'),'9') AS YOIL_20,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"'),'9') AS YOIL_21,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"'),'9') AS YOIL_22,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"'),'9') AS YOIL_23,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"'),'9') AS YOIL_24,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"'),'9') AS YOIL_25,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"'),'9') AS YOIL_26,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"'),'9') AS YOIL_27,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"'),'9') AS YOIL_28,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"'),'9') AS YOIL_29,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"'),'9') AS YOIL_30,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"'),'9') AS YOIL_31,	\n");					

			sb.append(" NVL(( SELECT A.STATUS FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '1'),'') AS STATUS,	\n");			
			sb.append("  B.PL_DEPT_CD AS TEAM_CD																		\n");
			
			sb.append(" FROM ASNHR.T_DI_HOLIDAY A, PMS.TSY200 B, ASNHR.T_CM_PERSON C	, PMS.TTS020 D					\n");
			sb.append(" WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'																\n");
			sb.append(" AND B.COST_CD = D.PJT_CD																								\n");
			sb.append(" AND D.SEQ = '1'																							\n");
			sb.append(" AND C.ENO_NO = D.ENO_NO																			\n");			
			sb.append(" AND C.ENO_NO = '"+p_box.get("ENO_NO")+"'														\n");

		}		
		
		if (SEQ.equals("2")) {

			sb.append("UNION ALL 																										\n");
			sb.append(" SELECT B.COST_CD AS PJT_CD,B.PLJ_NM AS PJT_NM,																										\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_01,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_02,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_03,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_04,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_05,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_06,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_07,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_08,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_09,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_10,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_11,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_12,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_13,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_14,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_15,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_16,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_17,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_18,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_19,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_20,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_21,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_22,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_23,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_24,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_25,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_26,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_27,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_28,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_29,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_30,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'0') AS DAY_31,	\n");			

			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'),'9') AS YOIL_01,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"'),'9') AS YOIL_02,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"'),'9') AS YOIL_03,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"'),'9') AS YOIL_04,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"'),'9') AS YOIL_05,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"'),'9') AS YOIL_06,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"'),'9') AS YOIL_07,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"'),'9') AS YOIL_08,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"'),'9') AS YOIL_09,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"'),'9') AS YOIL_10,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"'),'9') AS YOIL_11,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"'),'9') AS YOIL_12,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"'),'9') AS YOIL_13,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"'),'9') AS YOIL_14,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"'),'9') AS YOIL_15,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"'),'9') AS YOIL_16,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"'),'9') AS YOIL_17,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"'),'9') AS YOIL_18,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"'),'9') AS YOIL_19,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"'),'9') AS YOIL_20,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"'),'9') AS YOIL_21,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"'),'9') AS YOIL_22,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"'),'9') AS YOIL_23,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"'),'9') AS YOIL_24,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"'),'9') AS YOIL_25,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"'),'9') AS YOIL_26,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"'),'9') AS YOIL_27,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"'),'9') AS YOIL_28,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"'),'9') AS YOIL_29,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"'),'9') AS YOIL_30,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"'),'9') AS YOIL_31,	\n");					
			
			sb.append(" NVL(( SELECT A.STATUS FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '2'),'') AS STATUS,	\n");			
			sb.append("  B.PL_DEPT_CD AS TEAM_CD																		\n");
			
			sb.append(" FROM ASNHR.T_DI_HOLIDAY A, PMS.TSY200 B, ASNHR.T_CM_PERSON C	, PMS.TTS020 D					\n");
			sb.append(" WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'																\n");
			sb.append(" AND B.COST_CD = D.PJT_CD																								\n");
			sb.append(" AND D.SEQ = '2'																							\n");
			sb.append(" AND C.ENO_NO = D.ENO_NO																			\n");			
			sb.append(" AND C.ENO_NO = '"+p_box.get("ENO_NO")+"'														\n");

		}			
		
		if (SEQ.equals("3")) {

			sb.append("UNION ALL 																										\n");
			sb.append(" SELECT B.COST_CD AS PJT_CD,B.PLJ_NM AS PJT_NM,																										\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_01,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_02,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_03,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_04,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_05,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_06,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_07,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_08,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_09,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_10,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_11,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_12,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_13,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_14,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_15,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_16,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_17,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_18,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_19,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_20,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_21,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_22,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_23,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_24,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_25,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_26,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_27,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_28,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_29,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_30,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'0') AS DAY_31,	\n");			

			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'),'9') AS YOIL_01,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"'),'9') AS YOIL_02,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"'),'9') AS YOIL_03,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"'),'9') AS YOIL_04,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"'),'9') AS YOIL_05,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"'),'9') AS YOIL_06,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"'),'9') AS YOIL_07,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"'),'9') AS YOIL_08,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"'),'9') AS YOIL_09,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"'),'9') AS YOIL_10,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"'),'9') AS YOIL_11,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"'),'9') AS YOIL_12,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"'),'9') AS YOIL_13,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"'),'9') AS YOIL_14,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"'),'9') AS YOIL_15,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"'),'9') AS YOIL_16,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"'),'9') AS YOIL_17,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"'),'9') AS YOIL_18,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"'),'9') AS YOIL_19,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"'),'9') AS YOIL_20,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"'),'9') AS YOIL_21,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"'),'9') AS YOIL_22,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"'),'9') AS YOIL_23,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"'),'9') AS YOIL_24,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"'),'9') AS YOIL_25,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"'),'9') AS YOIL_26,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"'),'9') AS YOIL_27,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"'),'9') AS YOIL_28,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"'),'9') AS YOIL_29,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"'),'9') AS YOIL_30,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"'),'9') AS YOIL_31,	\n");					
			
			sb.append(" NVL(( SELECT A.STATUS FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '3'),'') AS STATUS,	\n");			
			sb.append("  B.PL_DEPT_CD AS TEAM_CD																		\n");
			
			sb.append(" FROM ASNHR.T_DI_HOLIDAY A, PMS.TSY200 B, ASNHR.T_CM_PERSON C	, PMS.TTS020 D					\n");
			sb.append(" WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'																\n");
			sb.append(" AND B.COST_CD = D.PJT_CD																								\n");
			sb.append(" AND D.SEQ = '3'																							\n");
			sb.append(" AND C.ENO_NO = D.ENO_NO																			\n");			
			sb.append(" AND C.ENO_NO = '"+p_box.get("ENO_NO")+"'														\n");

		}			

		if (SEQ.equals("4")) {

			sb.append("UNION ALL 																										\n");
			sb.append(" SELECT B.COST_CD AS PJT_CD,B.PLJ_NM AS PJT_NM,																										\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_01,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_02,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_03,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_04,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_05,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_06,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_07,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_08,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_09,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_10,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_11,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_12,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_13,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_14,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_15,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_16,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_17,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_18,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_19,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_20,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_21,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_22,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_23,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_24,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_25,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_26,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_27,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_28,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_29,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_30,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'0') AS DAY_31,	\n");			

			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'),'9') AS YOIL_01,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"'),'9') AS YOIL_02,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"'),'9') AS YOIL_03,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"'),'9') AS YOIL_04,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"'),'9') AS YOIL_05,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"'),'9') AS YOIL_06,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"'),'9') AS YOIL_07,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"'),'9') AS YOIL_08,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"'),'9') AS YOIL_09,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"'),'9') AS YOIL_10,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"'),'9') AS YOIL_11,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"'),'9') AS YOIL_12,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"'),'9') AS YOIL_13,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"'),'9') AS YOIL_14,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"'),'9') AS YOIL_15,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"'),'9') AS YOIL_16,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"'),'9') AS YOIL_17,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"'),'9') AS YOIL_18,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"'),'9') AS YOIL_19,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"'),'9') AS YOIL_20,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"'),'9') AS YOIL_21,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"'),'9') AS YOIL_22,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"'),'9') AS YOIL_23,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"'),'9') AS YOIL_24,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"'),'9') AS YOIL_25,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"'),'9') AS YOIL_26,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"'),'9') AS YOIL_27,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"'),'9') AS YOIL_28,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"'),'9') AS YOIL_29,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"'),'9') AS YOIL_30,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"'),'9') AS YOIL_31,	\n");					
			
			sb.append(" NVL(( SELECT A.STATUS FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '4'),'') AS STATUS,	\n");			
			sb.append("  B.PL_DEPT_CD AS TEAM_CD																		\n");
			
			sb.append(" FROM ASNHR.T_DI_HOLIDAY A, PMS.TSY200 B, ASNHR.T_CM_PERSON C	, PMS.TTS020 D					\n");
			sb.append(" WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'																\n");
			sb.append(" AND B.COST_CD = D.PJT_CD																								\n");
			sb.append(" AND D.SEQ = '4'																							\n");
			sb.append(" AND C.ENO_NO = D.ENO_NO																			\n");			
			sb.append(" AND C.ENO_NO = '"+p_box.get("ENO_NO")+"'														\n");

		}		
		
		if (SEQ.equals("5")) {

			sb.append("UNION ALL 																										\n");
			sb.append(" SELECT B.COST_CD AS PJT_CD,B.PLJ_NM AS PJT_NM,																										\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_01,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_02,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_03,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_04,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_05,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_06,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_07,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_08,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_09,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_10,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_11,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_12,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_13,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_14,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_15,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_16,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_17,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_18,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_19,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_20,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_21,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_22,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_23,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_24,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_25,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_26,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_27,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_28,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_29,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_30,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'0') AS DAY_31,	\n");			

			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'),'9') AS YOIL_01,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"'),'9') AS YOIL_02,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"'),'9') AS YOIL_03,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"'),'9') AS YOIL_04,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"'),'9') AS YOIL_05,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"'),'9') AS YOIL_06,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"'),'9') AS YOIL_07,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"'),'9') AS YOIL_08,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"'),'9') AS YOIL_09,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"'),'9') AS YOIL_10,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"'),'9') AS YOIL_11,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"'),'9') AS YOIL_12,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"'),'9') AS YOIL_13,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"'),'9') AS YOIL_14,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"'),'9') AS YOIL_15,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"'),'9') AS YOIL_16,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"'),'9') AS YOIL_17,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"'),'9') AS YOIL_18,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"'),'9') AS YOIL_19,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"'),'9') AS YOIL_20,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"'),'9') AS YOIL_21,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"'),'9') AS YOIL_22,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"'),'9') AS YOIL_23,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"'),'9') AS YOIL_24,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"'),'9') AS YOIL_25,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"'),'9') AS YOIL_26,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"'),'9') AS YOIL_27,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"'),'9') AS YOIL_28,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"'),'9') AS YOIL_29,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"'),'9') AS YOIL_30,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"'),'9') AS YOIL_31,	\n");					
			
			sb.append(" NVL(( SELECT A.STATUS FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '5'),'') AS STATUS,	\n");			
			sb.append("  B.PL_DEPT_CD AS TEAM_CD																		\n");
			
			sb.append(" FROM ASNHR.T_DI_HOLIDAY A, PMS.TSY200 B, ASNHR.T_CM_PERSON C	, PMS.TTS020 D					\n");
			sb.append(" WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'																\n");
			sb.append(" AND B.COST_CD = D.PJT_CD																								\n");
			sb.append(" AND D.SEQ = '5'																							\n");
			sb.append(" AND C.ENO_NO = D.ENO_NO																			\n");			
			sb.append(" AND C.ENO_NO = '"+p_box.get("ENO_NO")+"'														\n");

		}				
		
		if (SEQ.equals("6")) {

			sb.append("UNION ALL 																										\n");
			sb.append(" SELECT B.COST_CD AS PJT_CD,B.PLJ_NM AS PJT_NM,																										\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_01,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_02,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_03,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_04,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_05,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_06,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_07,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_08,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_09,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_10,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_11,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_12,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_13,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_14,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_15,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_16,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_17,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_18,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_19,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_20,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_21,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_22,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_23,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_24,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_25,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_26,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_27,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_28,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_29,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_30,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'0') AS DAY_31,	\n");			

			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'),'9') AS YOIL_01,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"'),'9') AS YOIL_02,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"'),'9') AS YOIL_03,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"'),'9') AS YOIL_04,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"'),'9') AS YOIL_05,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"'),'9') AS YOIL_06,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"'),'9') AS YOIL_07,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"'),'9') AS YOIL_08,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"'),'9') AS YOIL_09,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"'),'9') AS YOIL_10,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"'),'9') AS YOIL_11,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"'),'9') AS YOIL_12,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"'),'9') AS YOIL_13,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"'),'9') AS YOIL_14,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"'),'9') AS YOIL_15,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"'),'9') AS YOIL_16,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"'),'9') AS YOIL_17,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"'),'9') AS YOIL_18,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"'),'9') AS YOIL_19,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"'),'9') AS YOIL_20,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"'),'9') AS YOIL_21,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"'),'9') AS YOIL_22,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"'),'9') AS YOIL_23,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"'),'9') AS YOIL_24,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"'),'9') AS YOIL_25,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"'),'9') AS YOIL_26,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"'),'9') AS YOIL_27,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"'),'9') AS YOIL_28,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"'),'9') AS YOIL_29,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"'),'9') AS YOIL_30,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"'),'9') AS YOIL_31,	\n");					
			
			sb.append(" NVL(( SELECT A.STATUS FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '6'),'') AS STATUS,	\n");			
			sb.append("  B.PL_DEPT_CD AS TEAM_CD																		\n");
			
			sb.append(" FROM ASNHR.T_DI_HOLIDAY A, PMS.TSY200 B, ASNHR.T_CM_PERSON C	, PMS.TTS020 D					\n");
			sb.append(" WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'																\n");
			sb.append(" AND B.COST_CD = D.PJT_CD																								\n");
			sb.append(" AND D.SEQ = '6'																							\n");
			sb.append(" AND C.ENO_NO = D.ENO_NO																			\n");			
			sb.append(" AND C.ENO_NO = '"+p_box.get("ENO_NO")+"'														\n");

		}			
		
		if (SEQ.equals("7")) {

			sb.append("UNION ALL 																										\n");
			sb.append(" SELECT B.COST_CD AS PJT_CD,B.PLJ_NM AS PJT_NM,																										\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_01,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_02,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_03,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_04,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_05,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_06,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_07,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_08,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_09,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_10,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_11,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_12,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_13,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_14,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_15,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_16,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_17,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_18,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_19,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_20,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_21,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_22,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_23,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_24,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_25,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_26,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_27,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_28,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_29,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_30,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'0') AS DAY_31,	\n");			

			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'),'9') AS YOIL_01,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"'),'9') AS YOIL_02,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"'),'9') AS YOIL_03,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"'),'9') AS YOIL_04,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"'),'9') AS YOIL_05,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"'),'9') AS YOIL_06,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"'),'9') AS YOIL_07,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"'),'9') AS YOIL_08,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"'),'9') AS YOIL_09,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"'),'9') AS YOIL_10,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"'),'9') AS YOIL_11,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"'),'9') AS YOIL_12,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"'),'9') AS YOIL_13,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"'),'9') AS YOIL_14,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"'),'9') AS YOIL_15,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"'),'9') AS YOIL_16,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"'),'9') AS YOIL_17,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"'),'9') AS YOIL_18,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"'),'9') AS YOIL_19,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"'),'9') AS YOIL_20,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"'),'9') AS YOIL_21,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"'),'9') AS YOIL_22,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"'),'9') AS YOIL_23,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"'),'9') AS YOIL_24,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"'),'9') AS YOIL_25,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"'),'9') AS YOIL_26,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"'),'9') AS YOIL_27,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"'),'9') AS YOIL_28,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"'),'9') AS YOIL_29,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"'),'9') AS YOIL_30,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"'),'9') AS YOIL_31,	\n");					
			
			sb.append(" NVL(( SELECT A.STATUS FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '7'),'') AS STATUS,	\n");			
			sb.append("  B.PL_DEPT_CD AS TEAM_CD																		\n");
			
			sb.append(" FROM ASNHR.T_DI_HOLIDAY A, PMS.TSY200 B, ASNHR.T_CM_PERSON C	, PMS.TTS020 D					\n");
			sb.append(" WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'																\n");
			sb.append(" AND B.COST_CD = D.PJT_CD																								\n");
			sb.append(" AND D.SEQ = '7'																							\n");
			sb.append(" AND C.ENO_NO = D.ENO_NO																			\n");			
			sb.append(" AND C.ENO_NO = '"+p_box.get("ENO_NO")+"'														\n");

		}	

		if (SEQ.equals("8")) {

			sb.append("UNION ALL 																										\n");
			sb.append(" SELECT B.COST_CD AS PJT_CD,B.PLJ_NM AS PJT_NM,																										\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_01,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_02,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_03,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_04,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_05,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_06,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_07,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_08,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_09,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_10,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_11,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_12,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_13,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_14,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_15,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_16,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_17,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_18,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_19,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_20,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_21,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_22,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_23,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_24,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_25,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_26,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_27,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_28,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_29,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_30,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'0') AS DAY_31,	\n");			

			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'),'9') AS YOIL_01,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"'),'9') AS YOIL_02,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"'),'9') AS YOIL_03,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"'),'9') AS YOIL_04,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"'),'9') AS YOIL_05,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"'),'9') AS YOIL_06,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"'),'9') AS YOIL_07,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"'),'9') AS YOIL_08,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"'),'9') AS YOIL_09,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"'),'9') AS YOIL_10,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"'),'9') AS YOIL_11,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"'),'9') AS YOIL_12,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"'),'9') AS YOIL_13,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"'),'9') AS YOIL_14,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"'),'9') AS YOIL_15,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"'),'9') AS YOIL_16,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"'),'9') AS YOIL_17,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"'),'9') AS YOIL_18,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"'),'9') AS YOIL_19,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"'),'9') AS YOIL_20,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"'),'9') AS YOIL_21,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"'),'9') AS YOIL_22,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"'),'9') AS YOIL_23,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"'),'9') AS YOIL_24,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"'),'9') AS YOIL_25,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"'),'9') AS YOIL_26,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"'),'9') AS YOIL_27,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"'),'9') AS YOIL_28,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"'),'9') AS YOIL_29,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"'),'9') AS YOIL_30,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"'),'9') AS YOIL_31,	\n");					
			
			sb.append(" NVL(( SELECT A.STATUS FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '8'),'') AS STATUS,	\n");			
			sb.append("  B.PL_DEPT_CD AS TEAM_CD																		\n");
			
			sb.append(" FROM ASNHR.T_DI_HOLIDAY A, PMS.TSY200 B, ASNHR.T_CM_PERSON C	, PMS.TTS020 D					\n");
			sb.append(" WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'																\n");
			sb.append(" AND B.COST_CD = D.PJT_CD																								\n");
			sb.append(" AND D.SEQ = '8'																							\n");
			sb.append(" AND C.ENO_NO = D.ENO_NO																			\n");			
			sb.append(" AND C.ENO_NO = '"+p_box.get("ENO_NO")+"'														\n");

		}	


		if (SEQ.equals("9")) {

			sb.append("UNION ALL 																										\n");
			sb.append(" SELECT B.COST_CD AS PJT_CD,B.PLJ_NM AS PJT_NM,																										\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_01,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_02,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_03,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_04,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_05,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_06,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_07,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_08,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_09,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_10,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_11,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_12,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_13,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_14,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_15,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_16,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_17,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_18,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_19,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_20,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_21,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_22,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_23,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_24,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_25,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_26,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_27,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_28,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_29,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_30,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'0') AS DAY_31,	\n");			

			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'),'9') AS YOIL_01,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"'),'9') AS YOIL_02,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"'),'9') AS YOIL_03,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"'),'9') AS YOIL_04,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"'),'9') AS YOIL_05,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"'),'9') AS YOIL_06,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"'),'9') AS YOIL_07,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"'),'9') AS YOIL_08,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"'),'9') AS YOIL_09,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"'),'9') AS YOIL_10,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"'),'9') AS YOIL_11,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"'),'9') AS YOIL_12,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"'),'9') AS YOIL_13,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"'),'9') AS YOIL_14,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"'),'9') AS YOIL_15,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"'),'9') AS YOIL_16,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"'),'9') AS YOIL_17,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"'),'9') AS YOIL_18,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"'),'9') AS YOIL_19,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"'),'9') AS YOIL_20,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"'),'9') AS YOIL_21,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"'),'9') AS YOIL_22,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"'),'9') AS YOIL_23,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"'),'9') AS YOIL_24,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"'),'9') AS YOIL_25,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"'),'9') AS YOIL_26,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"'),'9') AS YOIL_27,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"'),'9') AS YOIL_28,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"'),'9') AS YOIL_29,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"'),'9') AS YOIL_30,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"'),'9') AS YOIL_31,	\n");					
			
			sb.append(" NVL(( SELECT A.STATUS FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '9'),'') AS STATUS,	\n");			
			sb.append("  B.PL_DEPT_CD AS TEAM_CD																		\n");
			
			sb.append(" FROM ASNHR.T_DI_HOLIDAY A, PMS.TSY200 B, ASNHR.T_CM_PERSON C	, PMS.TTS020 D					\n");
			sb.append(" WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'																\n");
			sb.append(" AND B.COST_CD = D.PJT_CD																								\n");
			sb.append(" AND D.SEQ = '9'																							\n");
			sb.append(" AND C.ENO_NO = D.ENO_NO																			\n");			
			sb.append(" AND C.ENO_NO = '"+p_box.get("ENO_NO")+"'														\n");

		}	

		if (SEQ.equals("10")) {

			sb.append("UNION ALL 																										\n");
			sb.append(" SELECT B.COST_CD AS PJT_CD,B.PLJ_NM AS PJT_NM,																										\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_01,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_02,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_03,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_04,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_05,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_06,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_07,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_08,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_09,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_10,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_11,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_12,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_13,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_14,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_15,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_16,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_17,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_18,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_19,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_20,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_21,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_22,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_23,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_24,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_25,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_26,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_27,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_28,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_29,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_30,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'0') AS DAY_31,	\n");			

			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'),'9') AS YOIL_01,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"'),'9') AS YOIL_02,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"'),'9') AS YOIL_03,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"'),'9') AS YOIL_04,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"'),'9') AS YOIL_05,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"'),'9') AS YOIL_06,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"'),'9') AS YOIL_07,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"'),'9') AS YOIL_08,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"'),'9') AS YOIL_09,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"'),'9') AS YOIL_10,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"'),'9') AS YOIL_11,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"'),'9') AS YOIL_12,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"'),'9') AS YOIL_13,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"'),'9') AS YOIL_14,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"'),'9') AS YOIL_15,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"'),'9') AS YOIL_16,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"'),'9') AS YOIL_17,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"'),'9') AS YOIL_18,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"'),'9') AS YOIL_19,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"'),'9') AS YOIL_20,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"'),'9') AS YOIL_21,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"'),'9') AS YOIL_22,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"'),'9') AS YOIL_23,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"'),'9') AS YOIL_24,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"'),'9') AS YOIL_25,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"'),'9') AS YOIL_26,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"'),'9') AS YOIL_27,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"'),'9') AS YOIL_28,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"'),'9') AS YOIL_29,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"'),'9') AS YOIL_30,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"'),'9') AS YOIL_31,	\n");					
			
			sb.append(" NVL(( SELECT A.STATUS FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '10'),'') AS STATUS,	\n");			
			sb.append("  B.PL_DEPT_CD AS TEAM_CD																		\n");
			
			sb.append(" FROM ASNHR.T_DI_HOLIDAY A, PMS.TSY200 B, ASNHR.T_CM_PERSON C	, PMS.TTS020 D					\n");
			sb.append(" WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'																\n");
			sb.append(" AND B.COST_CD = D.PJT_CD																								\n");
			sb.append(" AND D.SEQ = '10'																							\n");
			sb.append(" AND C.ENO_NO = D.ENO_NO																			\n");			
			sb.append(" AND C.ENO_NO = '"+p_box.get("ENO_NO")+"'														\n");

		}	

		if (SEQ.equals("11")) {

			sb.append("UNION ALL 																										\n");
			sb.append(" SELECT B.COST_CD AS PJT_CD,B.PLJ_NM AS PJT_NM,																										\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_01,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_02,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_03,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_04,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_05,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_06,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_07,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_08,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_09,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_10,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_11,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_12,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_13,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_14,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_15,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_16,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_17,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_18,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_19,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_20,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_21,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_22,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_23,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_24,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_25,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_26,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_27,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_28,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_29,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_30,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'0') AS DAY_31,	\n");			

			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'),'9') AS YOIL_01,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"'),'9') AS YOIL_02,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"'),'9') AS YOIL_03,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"'),'9') AS YOIL_04,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"'),'9') AS YOIL_05,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"'),'9') AS YOIL_06,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"'),'9') AS YOIL_07,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"'),'9') AS YOIL_08,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"'),'9') AS YOIL_09,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"'),'9') AS YOIL_10,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"'),'9') AS YOIL_11,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"'),'9') AS YOIL_12,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"'),'9') AS YOIL_13,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"'),'9') AS YOIL_14,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"'),'9') AS YOIL_15,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"'),'9') AS YOIL_16,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"'),'9') AS YOIL_17,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"'),'9') AS YOIL_18,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"'),'9') AS YOIL_19,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"'),'9') AS YOIL_20,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"'),'9') AS YOIL_21,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"'),'9') AS YOIL_22,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"'),'9') AS YOIL_23,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"'),'9') AS YOIL_24,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"'),'9') AS YOIL_25,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"'),'9') AS YOIL_26,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"'),'9') AS YOIL_27,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"'),'9') AS YOIL_28,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"'),'9') AS YOIL_29,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"'),'9') AS YOIL_30,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"'),'9') AS YOIL_31,	\n");					
						
			sb.append(" NVL(( SELECT A.STATUS FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '11'),'') AS STATUS,	\n");			
			sb.append("  B.PL_DEPT_CD AS TEAM_CD																		\n");
			
			sb.append(" FROM ASNHR.T_DI_HOLIDAY A, PMS.TSY200 B, ASNHR.T_CM_PERSON C	, PMS.TTS020 D					\n");
			sb.append(" WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'																\n");
			sb.append(" AND B.COST_CD = D.PJT_CD																								\n");
			sb.append(" AND D.SEQ = '11'																							\n");
			sb.append(" AND C.ENO_NO = D.ENO_NO																			\n");			
			sb.append(" AND C.ENO_NO = '"+p_box.get("ENO_NO")+"'														\n");

		}	

		if (SEQ.equals("12")) {

			sb.append("UNION ALL 																										\n");
			sb.append(" SELECT B.COST_CD AS PJT_CD,B.PLJ_NM AS PJT_NM,																										\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_01,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_02,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_03,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_04,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_05,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_06,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_07,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_08,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_09,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_10,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_11,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_12,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_13,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_14,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_15,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_16,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_17,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_18,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_19,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_20,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_21,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_22,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_23,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_24,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_25,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_26,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_27,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_28,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_29,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_30,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'0') AS DAY_31,	\n");			

			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'),'9') AS YOIL_01,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"'),'9') AS YOIL_02,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"'),'9') AS YOIL_03,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"'),'9') AS YOIL_04,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"'),'9') AS YOIL_05,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"'),'9') AS YOIL_06,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"'),'9') AS YOIL_07,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"'),'9') AS YOIL_08,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"'),'9') AS YOIL_09,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"'),'9') AS YOIL_10,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"'),'9') AS YOIL_11,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"'),'9') AS YOIL_12,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"'),'9') AS YOIL_13,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"'),'9') AS YOIL_14,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"'),'9') AS YOIL_15,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"'),'9') AS YOIL_16,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"'),'9') AS YOIL_17,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"'),'9') AS YOIL_18,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"'),'9') AS YOIL_19,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"'),'9') AS YOIL_20,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"'),'9') AS YOIL_21,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"'),'9') AS YOIL_22,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"'),'9') AS YOIL_23,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"'),'9') AS YOIL_24,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"'),'9') AS YOIL_25,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"'),'9') AS YOIL_26,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"'),'9') AS YOIL_27,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"'),'9') AS YOIL_28,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"'),'9') AS YOIL_29,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"'),'9') AS YOIL_30,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"'),'9') AS YOIL_31,	\n");					
			
			sb.append(" NVL(( SELECT A.STATUS FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '12'),'') AS STATUS,	\n");			
			sb.append("  B.PL_DEPT_CD AS TEAM_CD																		\n");
			
			sb.append(" FROM ASNHR.T_DI_HOLIDAY A, PMS.TSY200 B, ASNHR.T_CM_PERSON C	, PMS.TTS020 D					\n");
			sb.append(" WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'																\n");
			sb.append(" AND B.COST_CD = D.PJT_CD																								\n");
			sb.append(" AND D.SEQ = '12'																							\n");
			sb.append(" AND C.ENO_NO = D.ENO_NO																			\n");			
			sb.append(" AND C.ENO_NO = '"+p_box.get("ENO_NO")+"'														\n");

		}	

		if (SEQ.equals("13")) {

			sb.append("UNION ALL 																										\n");
			sb.append(" SELECT B.COST_CD AS PJT_CD,B.PLJ_NM AS PJT_NM,																										\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_01,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_02,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_03,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_04,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_05,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_06,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_07,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_08,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_09,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_10,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_11,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_12,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_13,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_14,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_15,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_16,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_17,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_18,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_19,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_20,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_21,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_22,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_23,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_24,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_25,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_26,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_27,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_28,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_29,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_30,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'0') AS DAY_31,	\n");			

			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'),'9') AS YOIL_01,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"'),'9') AS YOIL_02,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"'),'9') AS YOIL_03,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"'),'9') AS YOIL_04,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"'),'9') AS YOIL_05,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"'),'9') AS YOIL_06,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"'),'9') AS YOIL_07,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"'),'9') AS YOIL_08,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"'),'9') AS YOIL_09,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"'),'9') AS YOIL_10,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"'),'9') AS YOIL_11,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"'),'9') AS YOIL_12,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"'),'9') AS YOIL_13,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"'),'9') AS YOIL_14,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"'),'9') AS YOIL_15,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"'),'9') AS YOIL_16,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"'),'9') AS YOIL_17,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"'),'9') AS YOIL_18,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"'),'9') AS YOIL_19,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"'),'9') AS YOIL_20,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"'),'9') AS YOIL_21,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"'),'9') AS YOIL_22,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"'),'9') AS YOIL_23,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"'),'9') AS YOIL_24,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"'),'9') AS YOIL_25,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"'),'9') AS YOIL_26,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"'),'9') AS YOIL_27,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"'),'9') AS YOIL_28,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"'),'9') AS YOIL_29,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"'),'9') AS YOIL_30,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"'),'9') AS YOIL_31,	\n");					
			
			sb.append(" NVL(( SELECT A.STATUS FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '13'),'') AS STATUS,	\n");			
			sb.append("  B.PL_DEPT_CD AS TEAM_CD																		\n");
			
			sb.append(" FROM ASNHR.T_DI_HOLIDAY A, PMS.TSY200 B, ASNHR.T_CM_PERSON C	, PMS.TTS020 D					\n");
			sb.append(" WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'																\n");
			sb.append(" AND B.COST_CD = D.PJT_CD																								\n");
			sb.append(" AND D.SEQ = '13'																							\n");
			sb.append(" AND C.ENO_NO = D.ENO_NO																			\n");			
			sb.append(" AND C.ENO_NO = '"+p_box.get("ENO_NO")+"'														\n");

		}	

		if (SEQ.equals("14")) {

			sb.append("UNION ALL 																										\n");
			sb.append(" SELECT B.COST_CD AS PJT_CD,B.PLJ_NM AS PJT_NM,																										\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_01,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_02,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_03,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_04,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_05,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_06,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_07,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_08,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_09,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_10,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_11,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_12,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_13,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_14,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_15,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_16,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_17,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_18,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_19,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_20,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_21,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_22,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_23,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_24,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_25,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_26,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_27,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_28,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_29,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_30,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'0') AS DAY_31,	\n");			

			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'),'9') AS YOIL_01,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"'),'9') AS YOIL_02,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"'),'9') AS YOIL_03,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"'),'9') AS YOIL_04,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"'),'9') AS YOIL_05,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"'),'9') AS YOIL_06,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"'),'9') AS YOIL_07,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"'),'9') AS YOIL_08,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"'),'9') AS YOIL_09,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"'),'9') AS YOIL_10,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"'),'9') AS YOIL_11,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"'),'9') AS YOIL_12,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"'),'9') AS YOIL_13,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"'),'9') AS YOIL_14,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"'),'9') AS YOIL_15,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"'),'9') AS YOIL_16,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"'),'9') AS YOIL_17,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"'),'9') AS YOIL_18,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"'),'9') AS YOIL_19,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"'),'9') AS YOIL_20,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"'),'9') AS YOIL_21,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"'),'9') AS YOIL_22,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"'),'9') AS YOIL_23,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"'),'9') AS YOIL_24,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"'),'9') AS YOIL_25,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"'),'9') AS YOIL_26,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"'),'9') AS YOIL_27,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"'),'9') AS YOIL_28,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"'),'9') AS YOIL_29,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"'),'9') AS YOIL_30,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"'),'9') AS YOIL_31,	\n");					
			
			sb.append(" NVL(( SELECT A.STATUS FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '14'),'') AS STATUS,	\n");			
			sb.append("  B.PL_DEPT_CD AS TEAM_CD																		\n");
			
			sb.append(" FROM ASNHR.T_DI_HOLIDAY A, PMS.TSY200 B, ASNHR.T_CM_PERSON C	, PMS.TTS020 D					\n");
			sb.append(" WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'																\n");
			sb.append(" AND B.COST_CD = D.PJT_CD																								\n");
			sb.append(" AND D.SEQ = '14'																							\n");
			sb.append(" AND C.ENO_NO = D.ENO_NO																			\n");			
			sb.append(" AND C.ENO_NO = '"+p_box.get("ENO_NO")+"'														\n");

		}	

		if (SEQ.equals("15")) {

			sb.append("UNION ALL 																										\n");
			sb.append(" SELECT B.COST_CD AS PJT_CD,B.PLJ_NM AS PJT_NM,																										\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_01,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_02,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_03,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_04,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_05,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_06,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_07,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_08,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_09,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_10,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_11,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_12,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_13,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_14,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_15,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_16,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_17,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_18,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_19,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_20,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_21,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_22,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_23,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_24,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_25,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_26,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_27,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_28,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_29,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_30,	\n");
			sb.append(" NVL(( SELECT A.WTIME FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'0') AS DAY_31,	\n");			

			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'),'9') AS YOIL_01,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"02"+"'),'9') AS YOIL_02,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"03"+"'),'9') AS YOIL_03,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"04"+"'),'9') AS YOIL_04,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"05"+"'),'9') AS YOIL_05,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"06"+"'),'9') AS YOIL_06,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"07"+"'),'9') AS YOIL_07,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"08"+"'),'9') AS YOIL_08,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"09"+"'),'9') AS YOIL_09,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"10"+"'),'9') AS YOIL_10,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"11"+"'),'9') AS YOIL_11,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"12"+"'),'9') AS YOIL_12,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"13"+"'),'9') AS YOIL_13,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"14"+"'),'9') AS YOIL_14,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"15"+"'),'9') AS YOIL_15,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"16"+"'),'9') AS YOIL_16,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"17"+"'),'9') AS YOIL_17,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"18"+"'),'9') AS YOIL_18,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"19"+"'),'9') AS YOIL_19,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"20"+"'),'9') AS YOIL_20,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"21"+"'),'9') AS YOIL_21,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"22"+"'),'9') AS YOIL_22,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"23"+"'),'9') AS YOIL_23,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"24"+"'),'9') AS YOIL_24,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"25"+"'),'9') AS YOIL_25,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"26"+"'),'9') AS YOIL_26,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"27"+"'),'9') AS YOIL_27,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"28"+"'),'9') AS YOIL_28,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"29"+"'),'9') AS YOIL_29,	\n");				
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"30"+"'),'9') AS YOIL_30,	\n");	
			sb.append(" NVL(( SELECT A.HOL_GBN FROM ASNHR.T_DI_HOLIDAY A WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"31"+"'),'9') AS YOIL_31,	\n");					
			
			sb.append(" NVL(( SELECT A.STATUS FROM PMS.TTS010 A, PMS.TTS020 B, ASNHR.T_CM_PERSON C WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"' AND B.ENO_NO = '"+p_box.get("ENO_NO")+"' AND B.ENO_NO = C.ENO_NO AND A.ENO_NO = C.ENO_NO AND B.PJT_CD = A.PJT_CD AND B.SEQ = '15'),'') AS STATUS,	\n");			
			sb.append("  B.PL_DEPT_CD AS TEAM_CD																		\n");
			
			sb.append(" FROM ASNHR.T_DI_HOLIDAY A, PMS.TSY200 B, ASNHR.T_CM_PERSON C	, PMS.TTS020 D					\n");
			sb.append(" WHERE A.REG_YMD = '"+p_box.get("PIS_YM")+"01"+"'																\n");
			sb.append(" AND B.COST_CD = D.PJT_CD																								\n");
			sb.append(" AND D.SEQ = '15'																							\n");
			sb.append(" AND C.ENO_NO = D.ENO_NO																			\n");			
			sb.append(" AND C.ENO_NO = '"+p_box.get("ENO_NO")+"'														\n");

		}	


		
		
		
		
		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);		

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				
				p_box.get("PIS_YM"),				// ���				
				p_box.get("PIS_YM"),				// ���
				p_box.get("PIS_YM"),				// ���				
				p_box.get("PIS_YM"),				// ���				
				p_box.get("PIS_YM"),				// ���				
				p_box.get("PIS_YM"),				// ���
				p_box.get("PIS_YM"),				// ���				
				p_box.get("PIS_YM"),				// ���					
				p_box.get("PIS_YM"),				// ���				
				p_box.get("PIS_YM"),				// ���
				p_box.get("PIS_YM"),				// ���				
				p_box.get("PIS_YM"),				// ���				
				p_box.get("PIS_YM"),				// ���				
				p_box.get("PIS_YM"),				// ���
				p_box.get("PIS_YM"),				// ���				
				p_box.get("PIS_YM"),				// ���	
				p_box.get("PIS_YM"),				// ���				
				p_box.get("PIS_YM"),				// ���
				p_box.get("PIS_YM"),				// ���				
				p_box.get("PIS_YM"),				// ���				
				p_box.get("PIS_YM"),				// ���				
				p_box.get("PIS_YM"),				// ���
				p_box.get("PIS_YM"),				// ���				
				p_box.get("PIS_YM"),				// ���					
				p_box.get("PIS_YM"),				// ���				
				p_box.get("PIS_YM"),				// ���
				p_box.get("PIS_YM"),				// ���				
				p_box.get("PIS_YM"),				// ���				
				p_box.get("PIS_YM"),				// ���				
				p_box.get("PIS_YM"),				// ���
				p_box.get("PIS_YM"),				// ���								
				p_box.get("PIS_YM"),				// ���
				p_box.get("ENO_NO")					// ���
		};
		
		/** FirstRow�޼ҵ� ȣ�� **/
		return this.selectProcess(sql, bind, prop);
	}
	

	/**
	 * �ش����� � ������Ʈ�� ��ϵǾ� �ִ��� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EIST010_PJT(CBox p_box) throws CException {

		/** �ܺ� XML���� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST010_PJT2");	
	
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {			
				p_box.get("ENO_NO"),					//���					
				//p_box.get("PIS_YM"),					//���				
				//p_box.get("ENO_NO")					// ���
		};		
		

		/**Query  ���� �� �ڷ� ������� Return  **/
		return this.selectProcess(sql, bind, prop);
		
	}
	
	
	
	/**
     * ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void EIST010_INS(GauceValueObject vo, CBox p_box , int dd) throws CException {

		/** �ܺ� XML���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST010_INS");

		String  dd1 = Integer.toString(dd);

		if (dd1.length() == 1) {
			dd1 = "0" + dd1;
		}
		
        String REG_YMD = p_box.get("PIS_YM") + dd1;
        
        String WTIME = "0";
        
        //for (int j=1; j<31; j++){
        	
        switch(dd) {
        
			case 1:
				WTIME = JSPUtil.rns(vo.get("DAY_01")); break;
			case 2:        
				WTIME = JSPUtil.rns(vo.get("DAY_02")); break;        
			case 3:        
				WTIME = JSPUtil.rns(vo.get("DAY_03")); break; 
			case 4:        
				WTIME = JSPUtil.rns(vo.get("DAY_04")); break;        
			case 5:        
				WTIME = JSPUtil.rns(vo.get("DAY_05")); break;				
			case 6:        
				WTIME = JSPUtil.rns(vo.get("DAY_06")); break;        
			case 7:        
				WTIME = JSPUtil.rns(vo.get("DAY_07")); break; 
			case 8:        
				WTIME = JSPUtil.rns(vo.get("DAY_08")); break;        
			case 9:        
				WTIME = JSPUtil.rns(vo.get("DAY_09")); break;		
			case 10:        
				WTIME = JSPUtil.rns(vo.get("DAY_10")); break;        
			case 11:        
				WTIME = JSPUtil.rns(vo.get("DAY_11")); break; 
			case 12:        
				WTIME = JSPUtil.rns(vo.get("DAY_12")); break;        
			case 13:        
				WTIME = JSPUtil.rns(vo.get("DAY_13")); break;				
			case 14:        
				WTIME = JSPUtil.rns(vo.get("DAY_14")); break;        
			case 15:        
				WTIME = JSPUtil.rns(vo.get("DAY_15")); break; 
			case 16:        
				WTIME = JSPUtil.rns(vo.get("DAY_16")); break;        
			case 17:        
				WTIME = JSPUtil.rns(vo.get("DAY_17")); break;	
			case 18:        
				WTIME = JSPUtil.rns(vo.get("DAY_18")); break;				
			case 19:        
				WTIME = JSPUtil.rns(vo.get("DAY_19")); break;        
			case 20:        
				WTIME = JSPUtil.rns(vo.get("DAY_20")); break; 
			case 21:        
				WTIME = JSPUtil.rns(vo.get("DAY_21")); break;        
			case 22:        
				WTIME = JSPUtil.rns(vo.get("DAY_22")); break;		
			case 23:        
				WTIME = JSPUtil.rns(vo.get("DAY_23")); break;        
			case 24:       
				WTIME = JSPUtil.rns(vo.get("DAY_24")); break; 
			case 25:        
				WTIME = JSPUtil.rns(vo.get("DAY_25")); break;        
			case 26:        
				WTIME = JSPUtil.rns(vo.get("DAY_26")); break;				
			case 27:        
				WTIME = JSPUtil.rns(vo.get("DAY_27")); break;        
			case 28:        
				WTIME = JSPUtil.rns(vo.get("DAY_28")); break; 
			case 29:        
				WTIME = JSPUtil.rns(vo.get("DAY_29")); break;        
			case 30:        
				WTIME = JSPUtil.rns(vo.get("DAY_30")); break;					
			case 31:        
				WTIME = JSPUtil.rns(vo.get("DAY_31")); break;				
        }
        

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				
				REG_YMD,								//�����
				JSPUtil.rns(vo.get("PJT_CD")),			//������Ʈ �ڵ�
				JSPUtil.rns(vo.get("TEAM_CD")),			//������Ʈ �ڵ�				
				p_box.get("ENO_NO"),					//���
				WTIME,									//�ٹ��ð�
				p_box.get("ENO_NO"),
				p_box.get("ENO_NO")

		};
		

		/** INSERT�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);

	}
	
	/**
     * ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void EIST010_UPT_APP(GauceValueObject vo, CBox p_box, int dd ) throws CException {

		/** �ܺ� XML���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST010_UPT");
		
		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				
				p_box.get("ENO_NO"),					//���				
				p_box.get("PIS_YM"),					//���

		};
		

		/** UPDATE�޼ҵ� ȣ��  **/
		this.updateProcess(sql, bind);

	}
	
	
	/**
     * ��� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void EIST010_UPT2(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST010_UPT");
		
		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				
				p_box.get("ENO_NO"),					//���	
				p_box.get("ENO_NO"),					//���					
				p_box.get("PIS_YM"),					//���

		};
		

		/** UPDATE�޼ҵ� ȣ��  **/
		this.updateProcess(sql, bind);

	}	
	
	/**
     * ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void EIST010_DEL(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("eis", "EIST010_DEL");
		
		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM"),				// ���			
				p_box.get("ENO_NO"),				// ���
				JSPUtil.rns(vo.get("PJT_CD")),		// ������Ʈ �ڵ�
			
		};
		

		/** DELETE�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);

	}
	

}
