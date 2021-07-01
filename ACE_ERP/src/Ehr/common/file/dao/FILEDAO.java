package Ehr.common.file.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class FILEDAO extends AbstractDAO {
	public FILEDAO(String p_dsId, TrBox p_tr) throws CException {
		super(p_dsId, p_tr);
	}
    
    /**
     * ���ο� sequence ��ȣ�� ������ �´�.
     * @return
     * @throws CException
     */
    public String getSeq_no() throws CException {
    	
        String seq_no = null;
        
        String sql = XmlSqlUtils.getSQL("common", "FILE_SHR_SEQ");

        Object[] bind = new Object[] {
 
        };

        GauceValueObject vo = this.selectProcessGvo(sql, bind).get(0);
        
        seq_no = vo.getString("SEQ_NO");
        
        return seq_no;
    }
	
	/**
     * �����׸� ��ȸ 
     * @param p_box
     * @throws CException
	 */
	public void FILE_SHR(CBox p_box) throws CException {
		
		String sql = XmlSqlUtils.getSQL("common", "FILE_SHR");

		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("KEY")),                
                JSPUtil.rns(p_box.get("SEQ_NO"))           
		};
        
        prop.add("UPLOAD_URL", ColumnProp.COLUMN_TYPE_URL, 1000.0, ColumnProp.CONSTRAINT_TB_NORMAL);

		this.selectProcessFirstRow(sql, bind, prop);
	}
    
    /**
     * ���� �׸� ���
     * @param p_box
     * @param vo
     * @throws CException
     */
	public void FILE_INS(CBox p_box, GauceValueObject vo, String seq) throws CException {
		
	    String sql = XmlSqlUtils.getSQL("common", "FILE_INS");
	    
	    Object[] bind = new Object[] {
	    		
                JSPUtil.rns(vo.get("KEY")),        
                seq,
                JSPUtil.rns(vo.get("ORIGINAL_FILENAME")),          
                JSPUtil.rns(vo.get("UPLOAD_FILENAME")),       
                JSPUtil.rns(p_box.get("vusrid")),
                JSPUtil.rns(p_box.get("vusrid"))
	    };
	    
	    this.insertProcess(sql, bind);
	}
    
    /**
     * ���� �׸� ����
     * @param p_box
     * @param vo
     * @throws CException
     */
	public void FILE_DEL(CBox p_box, GauceValueObject vo) throws CException {
	    String sql = XmlSqlUtils.getSQL("common", "FILE_DEL");
	    
	    Object[] bind = new Object[] {
                JSPUtil.rns(vo.get("KEY")),   
                JSPUtil.rns(vo.get("SEQ_NO"))  
	    };
	    
	    this.deleteProcess(sql, bind);
	}
}
