package Ehr.pir.a.pira032.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA032DAO extends AbstractDAO {
		/** 
		 * PIRA032DAO 생성자
		 * @param p_conn	Connection
		 * @param p_tr		TrBox
		 * @throws CException
		 */
		public PIRA032DAO(String p_dsId, TrBox p_tr) throws CException {
			
			/** SuperClass의 생성자 호출 **/
			super(p_dsId, p_tr);
			
		}
		
		/**
		 * 사번생성 SELECT를 수행하는 DAO 메소드
		 * @param p_box
		 * @throws CException
		 */
		public void PIRA032_SHR(CBox p_box) throws CException {
			
			/** 외부 XML에서 사번생성 데이터 조회 SQL 읽음 **/
			String sql = null;
			
			// 정규사원
			if (p_box.get("GUBUN").equals("1")) {
				sql = XmlSqlUtils.getSQL("pir", "PIRA032_SHR");
			}
			// 파견사원
			else if (p_box.get("GUBUN").equals("2")) {
				sql = XmlSqlUtils.getSQL("pir", "PIRA032_SHR_02");
			}
			
			/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
			Object[] bind = new Object[] {
			};
			
			/** FirstRow메소드 호출 **/
			this.selectProcessFirstRow(sql, bind, prop);
		}
}
