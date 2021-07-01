package Ehr.gun.d.gund030.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUND030DAO extends AbstractDAO {
	/**
	 * GUND030DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUND030DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 연차발생관리  조회용  DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUND030_SHR(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND030_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),

		};
		
        prop.add("YRP_CNT"    ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("AYRP_CNT"  ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("TOT_YRP"  ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        
		/** SELECT메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
		

	}

	/**
	 * 연차발생관리 INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void GUND030_INS(CBox p_box) throws CException {

		/** 외부 XML에서 인사정보에서 사번을 읽어들여 평가대상설정 데이터를 일괄 생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND030_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("vusrid"),       					// 사번
				p_box.get("vusrid"),       					// 사번
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
				p_box.get("PIS_YY"),                        // 일괄처리년도
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);

	}

	/**
     * 출장품의서 삭제 DAO 메서드
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void GUND030_DEL(CBox p_box ) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND030_DEL");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),                         // 년도
		};

		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);

	}

	/**
	 * 연차발생관리 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void GUND030_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 평가대상설정 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND030_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("YRP_M1"),                          // 1월 연차
				vo.get("YRP_M2"),                          // 2월 연차
				vo.get("YRP_M3"),                          // 3월 연차
				vo.get("YRP_M4"),                          // 4월 연차
				vo.get("YRP_M5"),                          // 5월 연차
				vo.get("YRP_M6"),                          // 6월 연차
				vo.get("YRP_M7"),                          // 7월 연차
				vo.get("YRP_M8"),                          // 8월 연차
				vo.get("YRP_M9"),                          // 9월 연차
				vo.get("YRP_M10"),                        // 10월 연차
				vo.get("YRP_M11"),                        // 11월 연차
				vo.get("YRP_M12"),                        // 12월 연차
				vo.get("AYRP_M1"),                        // 1월 선연차
				vo.get("AYRP_M2"),                        // 2월 선연차
				vo.get("AYRP_M3"),                        // 3월 선연차
				vo.get("AYRP_M4"),                        // 4월 선연차
				vo.get("AYRP_M5"),                        // 5월 선연차
				vo.get("AYRP_M6"),                        // 6월 선연차
				vo.get("AYRP_M7"),                        // 7월 선연차
				vo.get("AYRP_M8"),                        // 8월 선연차
				vo.get("AYRP_M9"),                        // 9월 선연차
				vo.get("AYRP_M10"),                      // 10월 선연차
				vo.get("AYRP_M11"),                      // 11월 선연차
				vo.get("AYRP_M12"),                      // 12월 선연차
				vo.get("YRP_CNT"),                        // 연차합
				vo.get("AYRP_CNT"),                      // 선연차합
				p_box.get("vusrid"),     						// 수정자
				vo.get("PIS_YY"),                           // 년도
				vo.get("ENO_NO")                          // 사번
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}
}
