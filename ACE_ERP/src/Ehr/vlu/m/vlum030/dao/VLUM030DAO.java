package Ehr.vlu.m.vlum030.dao;

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

public class VLUM030DAO extends AbstractDAO {

	public VLUM030DAO(String p_dsId, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	public void VLUM030_SHR_01(CBox p_box) throws CException {  

		String sql = XmlSqlUtils.getSQL("vlu", "VLUM030_SHR_01");


		Object[] bind = new Object[] {

				//p_box.get("ENO_NO"),                       						// 피고과자
				p_box.get("EVA_SEQ"),                       						// 차수				
				p_box.get("ENO_NO"),                       							// 피고과자				
		};
		

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	public void VLUM030_SHR_02(CBox p_box) throws CException {  

		String sql = XmlSqlUtils.getSQL("vlu", "VLUM030_SHR_02");


		Object[] bind = new Object[] {

				p_box.get("REG_YM_SHR").replaceAll("-", ""),                        // 고과년월
				p_box.get("ENO_NO"),                       							// 피고과자
				p_box.get("EVA_SEQ"),                       						// 차수				
		};
		

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	public void VLUM030_SHR_03(CBox p_box) throws CException {  

		String sql = XmlSqlUtils.getSQL("vlu", "VLUM030_SHR_03");


		Object[] bind = new Object[] {

				p_box.get("REG_YM_SHR").replaceAll("-", ""),                        // 고과년월
				p_box.get("ENO_NO"),                       							// 피고과자		
		};
		

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}	

}
