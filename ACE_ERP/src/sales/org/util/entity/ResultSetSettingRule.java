/*
 * 작성자 : 이동연
 * 파일명 : ExtractRule.java
 * 작성일 : 2004-05-29
 */
package sales.org.util.entity;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

public class ResultSetSettingRule implements IEntitySettingRule {
	public void set(EntitySetter setter, Object src) {
		try {
			ResultSet rs = (ResultSet)src;
			ResultSetMetaData rsmd = rs.getMetaData();
			int numberOfColumns = rsmd.getColumnCount();

			for (int i=1; i <= numberOfColumns; i++) {
				setter.setValue(EntityUtil.getFieldNameFromColumn(rsmd.getColumnName(i)), rs.getObject(i));
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
}
