package Ehr.gun.a.guna100.dao;

import com.gauce.GauceDataRow;
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

public class GUNA100DAO extends AbstractDAO {
	/**
	 * PIRA030DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNA100DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 개인별 근태 집계 현황 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void GUNA100_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 개인별 근태 집계 현황 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA100_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				
				p_box.get("PIS_YY"),	    			// 해당년
				p_box.get("PIS_MM_STR"),	    		// 해당월(시작)
				p_box.get("PIS_MM_END"),				// 해당월(종료)
				p_box.get("ENO_NO"),					// 사번
				p_box.get("PIS_YY"),	    			// 해당년
				p_box.get("PIS_YY"),	    			// 해당년
				p_box.get("PIS_YY"),	    			// 해당년
				p_box.get("PIS_MM_STR"),	    		// 해당월(시작)
				p_box.get("PIS_MM_END"),				// 해당월(종료)
				p_box.get("ENO_NO"),					// 사번
		};

        prop.add("YRP_CNT2"  	,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);		
        prop.add("MPH_CNT2"  	,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        
		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}


	/**
	 * 개인별 연차 현황 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNA100_SHR_02(CBox p_box) throws CException {


        //System.out.println("---============================================->"+p_box);

		/** 외부 XML에서 개인별휴가사용현황 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA100_SHR_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),	    			// 년도
				p_box.get("ENO_NO"),					// 사번			
		};

        prop.add("YRP_CNT"  	,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("YRP_ATT_H"    ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("REM_YRP"  	,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);

		/** FirstRow메소드 호출 **/
		return this.selectProcess(sql, bind, prop);
	}


	/**
	 * 개인별근태집계현황 수정
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNA100_UPT(GauceValueObject vo, CBox p_box) throws CException {

		int ATT_E = 0;
		int ATT_F = 0;
		int ATT_I = 0;
		int ATT_H = 0;
		int ATT_P = 0;
		int ATT_R = 0;
		int ATT_T = 0;
		int ATT_Z = 0;		
		int ATW_CNT = 0;
		int HOL_CNT = 0;

		for(int i=1;i<=31;i++){
			if(vo.get("AT"+i+"_CD").equals("E")){
				ATT_E = ATT_E + 1;
			}else if(vo.get("AT"+i+"_CD").equals("F")){
				ATT_F = ATT_F + 1;
			}else if(vo.get("AT"+i+"_CD").equals("H")){
				ATT_H = ATT_H + 1;
			}else if(vo.get("AT"+i+"_CD").equals("I")){
				ATT_I = ATT_I + 1;
			}else if(vo.get("AT"+i+"_CD").equals("P")){
				ATT_P = ATT_P + 1;
			}else if(vo.get("AT"+i+"_CD").equals("R")){
				ATT_R = ATT_R + 1;
			}else if(vo.get("AT"+i+"_CD").equals("W")){
				ATW_CNT = ATW_CNT + 1;
			}else if(vo.get("AT"+i+"_CD").equals("Y")){
				HOL_CNT = HOL_CNT + 1;
			}else if(vo.get("AT"+i+"_CD").equals("T")){
				ATT_T = ATT_T + 1;
			}else if(vo.get("AT"+i+"_CD").equals("Z")){
				ATT_Z = ATT_Z + 1;				
			}
		}

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA100_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				vo.get("AT1_CD"),
				vo.get("AT2_CD"),
				vo.get("AT3_CD"),
				vo.get("AT4_CD"),
				vo.get("AT5_CD"),
				vo.get("AT6_CD"),
				vo.get("AT7_CD"),
				vo.get("AT8_CD"),
				vo.get("AT9_CD"),
				vo.get("AT10_CD"),
				vo.get("AT11_CD"),
				vo.get("AT12_CD"),
				vo.get("AT13_CD"),
				vo.get("AT14_CD"),
				vo.get("AT15_CD"),
				vo.get("AT16_CD"),
				vo.get("AT17_CD"),
				vo.get("AT18_CD"),
				vo.get("AT19_CD"),
				vo.get("AT20_CD"),
				vo.get("AT21_CD"),
				vo.get("AT22_CD"),
				vo.get("AT23_CD"),
				vo.get("AT24_CD"),
				vo.get("AT25_CD"),
				vo.get("AT26_CD"),
				vo.get("AT27_CD"),
				vo.get("AT28_CD"),
				vo.get("AT29_CD"),
				vo.get("AT30_CD"),
				vo.get("AT31_CD"),
				Integer.toString(ATT_E),
				Integer.toString(ATT_F),
				Integer.toString(ATT_H),
				Integer.toString(ATT_I),				
				Integer.toString(ATT_P),
				Integer.toString(ATT_R),
				Integer.toString(ATT_T),
				Integer.toString(ATT_Z),				
				Integer.toString(ATW_CNT),
				Integer.toString(HOL_CNT),
				p_box.get("vusrid"),
				vo.get("PIS_YYMM").substring(0, 4),
				vo.get("PIS_YYMM").substring(5, 7),
				vo.get("ENO_NO")
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
		
	}


}
