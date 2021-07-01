package Ehr.gun.a.guna018.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class GUNA018DAO extends AbstractDAO {
	/**
	 * GUNA018DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNA018DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 개인별 근태 현황 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNA018_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 개인별 근태 현황 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA018_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),	    			// 해당년
				p_box.get("PIS_MM_STR"),	    		// 해당월(시작)
				p_box.get("PIS_MM_END"),				// 해당월(종료)
				p_box.get("ENO_NO"),					// 사번
				p_box.get("PIS_YY"),	    			// 해당년
				p_box.get("PIS_MM_STR"),	    		// 해당월(시작)
				p_box.get("PIS_MM_END"),				// 해당월(종료)
				p_box.get("ENO_NO"),					// 사번
		};

        prop.add("YRP_CNT"   	,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MPH_CNT"  	,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);

		/** FirstRow메소드 호출 **/
		return this.selectProcess(sql, bind, prop);
	}

	/**
	 * 개인별휴가사용현황 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNA018_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 개인별휴가사용현황 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA018_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),	    			// 년도
				p_box.get("ENO_NO"),					// 사번
 		
		};

        prop.add("YRP_CNT"  	,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("YRP_ATT_H"    ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("REM_YRP"  	,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MPH_CNT"  	,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("UMPH_CNT"     ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("LMPH_CNT"  	,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        
		/** FirstRow메소드 호출 **/
		return this.selectProcess(sql, bind, prop);
	}

	/**
	 * 개인연차갯수를 최초 저장하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNA018_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA018_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
			p_box.get("PIS_YY"),
			JSPUtil.rns(vo.get("ENO_NO")),
			JSPUtil.rns(vo.get("YRP_CNT"))
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 개인연차갯수를 업데이트 저장하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNA018_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA018_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

			JSPUtil.rns(vo.get("YRP_CNT")),
			p_box.get("PIS_YY"),
			JSPUtil.rns(vo.get("ENO_NO"))

		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

}
