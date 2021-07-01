package Ehr.yac.a.yaca011.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class YACA011DAO extends AbstractDAO {

	public YACA011DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

    /**
     * 연말정산결과조회를 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA011_SHR(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA011_SHR");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("SUBMIT_SHR")
        };

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }
    
    /**
     * 연말정산결과조회를 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA011_SHR_14(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA011_SHR_14");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("SUBMIT_SHR")
        };

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }    
    
    public void YACA011_SHR_15(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA011_SHR_15");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("SUBMIT_SHR")
        };

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }    
    
    public void YACA011_UPT(GauceValueObject vo, CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("yac", "YACA011_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("FUN_CNT"),
				vo.get("ENO_NO"),          		//TAG
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
    } 
    
    public void YACA011_UPT_14(GauceValueObject vo, CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("yac", "YACA011_UPT_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("FUN_CNT"),
				vo.get("ENO_NO"),          		//TAG
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
    }     
    
}
