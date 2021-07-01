package common.groupware;

import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import common.util.JSPUtil;

public class DiligenceDAO extends AbstractDAO{
    /**
     * LOGINDAO 생성자
     * @param p_conn       Connection
     * @param p_tr         TrBox
     * @throws CException
     */
	public DiligenceDAO(String p_conn) throws CException {

			/** SuperClass의 생성자 호출 **/
			super(p_conn);
	}
	/**
	 * 이전 휴일 체크하여 'Y'로 수정하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GROUPWARE_UPT_01(String GUN_YMD, CBox p_box) throws CException {

		int cnt = 0;
		String sqlSHR = "";
		String preYYMM = "";
		String COLNAME = "";
		String sqlUPT = "";

		GauceDataSet gsSHR = null;

		//이전달까지 휴일 조회
		String   sql_05 = XmlSqlUtils.getSQL("gun", "GUNA010_SHR_05");
		Object[] bind_05 = new Object[] {
				GUN_YMD.substring(0,6),
				GUN_YMD.substring(0,6),
				GUN_YMD,
		};
		AbstractDAO dao = new AbstractDAO("default");
		GauceDataSet gs = dao.selectProcess(sql_05, bind_05, prop);

		//이전달
		if(gs.getDataRowCnt() > 0 && !GUN_YMD.substring(0,6).equals(gs.getDataRow(0).getString(0).substring(0,6))){

			//이전달 휴일 공백 체크
			sqlSHR = "SELECT ENO_NO FROM T_DI_DILIGENCE   \n";
			sqlSHR += "WHERE   PIS_YY = '"+gs.getDataRow(0).getString(0).substring(0,4)+"'  \n";
			sqlSHR += "AND     PIS_MM = '"+gs.getDataRow(0).getString(0).substring(4,6)+"'  \n";

			for(int i=0; i<gs.getDataRowCnt(); i++){
				if(i != 0 && !preYYMM.equals(gs.getDataRow(i).getString(0).substring(0,6))){
					break;
				}else if(i == 0){
					sqlSHR += "AND (  \n";
				}else{
					sqlSHR += "OR   ";
				}

				sqlSHR += "AT"+gs.getDataRow(i).getString(1)+"_CD IS NULL   \n";

				cnt++;
				preYYMM = gs.getDataRow(i).getString(0).substring(0,6);
			}

			sqlSHR += ")  \n";
			dao = new AbstractDAO("default");
			gsSHR = dao.selectProcess(sqlSHR, new Object[]{}, prop);

			//이전달 휴일필드에 Y값 표기
			if(gsSHR.getDataRowCnt() > 0){
				sqlUPT = "UPDATE  T_DI_DILIGENCE SET \n";

				for(int i=0; i<cnt; i++){

					COLNAME = "AT"+gs.getDataRow(i).getString(1)+"_CD";
					sqlUPT += COLNAME+ " = DECODE("+COLNAME+", NULL, 'Y', "+COLNAME+")   \n";

					if(i != cnt-1){
						sqlUPT += ",";
					}
				}
				sqlUPT += "WHERE   PIS_YY = '"+gs.getDataRow(0).getString(0).substring(0,4)+"'  \n";
				sqlUPT += "AND     PIS_MM = '"+gs.getDataRow(0).getString(0).substring(4,6)+"'  \n";
				dao = new AbstractDAO("default");
				dao.updateProcess(sqlUPT, new Object[] {});
			}

		}

		//오늘날짜 이전 현재달
		if(gs.getDataRowCnt() > cnt && GUN_YMD.substring(0,6).equals(gs.getDataRow(cnt).getString(0).substring(0,6))){

			//현재달 휴일 공백 체크
			sqlSHR = "SELECT ENO_NO FROM T_DI_DILIGENCE   \n";
			sqlSHR += "WHERE   PIS_YY = '"+gs.getDataRow(cnt).getString(0).substring(0,4)+"'  \n";
			sqlSHR += "AND     PIS_MM = '"+gs.getDataRow(cnt).getString(0).substring(4,6)+"'  \n";

			for(int i=cnt; i<gs.getDataRowCnt(); i++){
				if(i == cnt){
					sqlSHR += "AND (  \n";
				}else{
					sqlSHR += "OR   ";
				}

				sqlSHR += "AT"+gs.getDataRow(i).getString(1)+"_CD IS NULL   \n";
			}

			sqlSHR += ")  \n";
			dao = new AbstractDAO("default");
			gsSHR = dao.selectProcess(sqlSHR, new Object[]{}, prop);

			//현재달 휴일필드에 Y값 표기
			if(gsSHR.getDataRowCnt() > 0){
				sqlUPT = "UPDATE  T_DI_DILIGENCE SET \n";

				for(int i=cnt; i<gs.getDataRowCnt(); i++){

					COLNAME = "AT"+gs.getDataRow(i).getString(1)+"_CD";
					sqlUPT += COLNAME+ " = DECODE("+COLNAME+", NULL, 'Y', "+COLNAME+")   \n";

					if(i != gs.getDataRowCnt()-1){
						sqlUPT += ",";
					}
				}
				sqlUPT += "WHERE   PIS_YY = '"+gs.getDataRow(cnt).getString(0).substring(0,4)+"'  \n";
				sqlUPT += "AND     PIS_MM = '"+gs.getDataRow(cnt).getString(0).substring(4,6)+"'  \n";
				dao = new AbstractDAO("default");
				dao.updateProcess(sqlUPT, new Object[] {});
			}

		}

	}
	/**
	 * T_DI_DILIGENCE 에 없는데이터를 반영
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GROUPWARE_INS_01(CBox p_box, String PIS_YYMMDD, String DPT_CD) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA015_INS_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				PIS_YYMMDD.substring(0,4),
				p_box.get("ENO_NO"),
				DPT_CD,
				PIS_YYMMDD.substring(0,4),
				p_box.get("ENO_NO"),
				p_box.get("ENO_NO"),
				PIS_YYMMDD.substring(0,4),
				p_box.get("ENO_NO"),
		};
		AbstractDAO dao = new AbstractDAO("default");
		/** UPDATE메소드 호출  **/
		dao.insertProcess(sql, bind);

	}

	/**
	 * T_DI_DILIGENCE 에 반영
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GROUPWARE_UPT_01(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box) throws CException {
		String GUN_YMD = PIS_YYMMDD.replaceAll("-", "");
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_01");


		String COLNAME = "AT"+Integer.parseInt(GUN_YMD.substring(6,8))+"_CD = DECODE(AT"+Integer.parseInt(GUN_YMD.substring(6,8))+"_CD, null,'" + GUN_CD + "', AT"+Integer.parseInt(GUN_YMD.substring(6,8))+"_CD),";
		StringBuffer sb = new StringBuffer();

		sb.append(COLNAME);

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				ENO_NO,
				GUN_YMD.substring(0, 4),
				GUN_YMD.substring(4, 6),
				ENO_NO,
		};
		AbstractDAO dao = new AbstractDAO("default");
		/** UPDATE메소드 호출  **/
		dao.updateProcess(sql, bind);

	}
	/**
	 * 근태총계를 수정하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GROUPWARE_UPT_02(String PIS_YYYYMMDD, String ENO_NO, CBox p_box) throws CException {

		String GUN_YMD = PIS_YYYYMMDD.replaceAll("-", "");

		// 총 카운트 update
		String sqlSUM = XmlSqlUtils.getSQL("gun", "GUNA015_SHR_01");
		Object[] bindSUM = new Object[] {
			GUN_YMD.substring(0,4),
			GUN_YMD.substring(4,6),
			ENO_NO,
		};
		AbstractDAO dao = new AbstractDAO("default");
		GauceDataSet gsSUM = dao.selectProcess(sqlSUM, bindSUM, prop);

		GauceDataRow grRead = null;
		String sql = XmlSqlUtils.getSQL("gun", "GUNA010_UPT_02");//근태변경신청현황 같이 사용

		for(int i=0; i<gsSUM.getDataRowCnt(); i++){
			grRead = gsSUM.getDataRow(i);
			ENO_NO = grRead.getString(0);

			int ATT_A     = 0;			int ATT_B     = 0;			int ATT_C     = 0;			int ATT_D     = 0;
			int ATT_E     = 0;			int ATT_F     = 0;			int ATT_G     = 0;			int ATT_H     = 0;
			int ATT_I     = 0;			int ATT_J     = 0;			int ATT_K     = 0;			int ATT_L     = 0;
			int ATT_M     = 0;			int ATT_N     = 0;			int ATT_O     = 0;			int ATT_P     = 0;
			int ATT_Q     = 0;			int ATT_R     = 0;			int ATT_S     = 0;			int ATT_U     = 0;
			int ATT_V     = 0;			int ATT_X     = 0;			int ATT_Z     = 0;			int ATW_CNT   = 0;
			int HOL_CNT   = 0;			int HOW_CNT   = 0;

			for(int j=1; j<gsSUM.getDataColCnt(); j++){
				if(grRead.getString(j) != null ){
					if(grRead.getString(j).equals("A")) ATT_A++;
					else if(grRead.getString(j).equals("B")) ATT_B++;
					else if(grRead.getString(j).equals("C")) ATT_C++;
					else if(grRead.getString(j).equals("D")) ATT_D++;
					else if(grRead.getString(j).equals("E")) ATT_E++;
					else if(grRead.getString(j).equals("F")) ATT_F++;
					else if(grRead.getString(j).equals("G")) ATT_G++;
					else if(grRead.getString(j).equals("H")) ATT_H++;
					else if(grRead.getString(j).equals("I")) ATT_I++;
					else if(grRead.getString(j).equals("J")) ATT_J++;
					else if(grRead.getString(j).equals("K")) ATT_K++;
					else if(grRead.getString(j).equals("L")) ATT_L++;
					else if(grRead.getString(j).equals("M")) ATT_M++;
					else if(grRead.getString(j).equals("N")) ATT_N++;
					else if(grRead.getString(j).equals("O")) ATT_O++;
					else if(grRead.getString(j).equals("P")) ATT_P++;
					else if(grRead.getString(j).equals("Q")) ATT_Q++;
					else if(grRead.getString(j).equals("R")) ATT_R++;
					else if(grRead.getString(j).equals("S")) ATT_S++;
					else if(grRead.getString(j).equals("U")) ATT_U++;
					else if(grRead.getString(j).equals("V")) ATT_V++;
					else if(grRead.getString(j).equals("X")) ATT_X++;
					else if(grRead.getString(j).equals("Z")) ATT_Z++;
					else if(grRead.getString(j).equals("W")) ATW_CNT++;
					else if(grRead.getString(j).equals("Y")) HOL_CNT++;
					else if(grRead.getString(j).equals("T")) HOW_CNT++;
				}
			}

			Object[] bind = new Object[] {
					ATT_A+"",
					ATT_B+"",
					ATT_C+"",
					ATT_D+"",
					ATT_E+"",
					ATT_F+"",
					ATT_G+"",
					ATT_H+"",
					ATT_I+"",
					ATT_J+"",
					ATT_K+"",
					ATT_L+"",
					ATT_M+"",
					ATT_N+"",
					ATT_O+"",
					ATT_P+"",
					ATT_Q+"",
					ATT_R+"",
					ATT_S+"",
					ATT_U+"",
					ATT_V+"",
					ATT_X+"",
					ATT_Z+"",
					ATW_CNT+"",
					HOL_CNT+"",
					HOW_CNT+"",
					ENO_NO,
					GUN_YMD.substring(0,4),
					GUN_YMD.substring(4,6),
					ENO_NO,
			};
			dao = new AbstractDAO("default");
			/** UPDATE메소드 호출  **/
			dao.updateProcess(sql, bind);
		}
	}
	/*
	 * asn 직원여부 조회
	 */
    public  GauceDataSet GROUPWARE_SHR_02(CBox p_box) throws CException {
    	AbstractDAO dao = new AbstractDAO("default");
		/** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("gun", "GUNA015_SHR_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				  p_box.get("ENO_NO"),

		};

		/** UPDATE메소드 호출  **/
		 //updateProcess(sql, bind);

		 return dao.selectProcess(sql, bind, this.prop);

	}

	/*
	 * 회계코드로 각 직원의 출근시간 정보 조회
	 */
    public  GauceDataSet GROUPWARE_SHR_03(CBox p_box) throws CException {
    	//AbstractDAO dao = new AbstractDAO("default");
		/** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("gun", "GUNA015_SHR_03");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				  p_box.get("ENO_NO"),

		};

		 return this.selectProcess(sql, bind, this.prop);

	}
}