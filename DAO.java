/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package maligno;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

/**
 *
 * @author u15194
 */
public class DAO {

	public static void Inserir(MeuPreparedStatement db, String tabela, Map<Object, Object> map)
					throws SQLException {
		String sql = "INSERT INTO " + tabela + " (";
		String valores = " values(";
		for (Iterator<Map.Entry<Object, Object>> it = map.entrySet().iterator(); it.hasNext();) {
			sql += it.next().getKey();
			valores += "?";
			if (it.hasNext()) {
				sql += ",";
				valores += ",";
			}
		}
		sql += ")";
		valores += ")";

		db.prepareStatement(sql + valores);

		int i = 1;
		for (Object value : map.values()) {
			db.setObject(i++, value);
		}
		db.executeUpdate();
		db.commit();
	}

	public static MeuResultSet Pesquisa(MeuPreparedStatement db, String tabela, Map.Entry<Object, Object> e)
					throws SQLException {
		String sql = "SELECT * FROM " + tabela + " WHERE " + e.getKey() + "= ?";

		db.prepareStatement(sql);
		db.setObject(1, e.getValue());

		return (MeuResultSet) db.executeQuery();
	}

	public static void Atualiza(MeuPreparedStatement db, String tabela, Map.Entry<Object, Object> id, Map<Object, Object> map)
					throws SQLException {
		String sql = "UPDATE " + tabela;
		String set = " SET ";
		String where = " WHERE ";

		where += id.getKey() + "=?";

		for (Iterator<Map.Entry<Object, Object>> it = map.entrySet().iterator(); it.hasNext();) {
			set += it.next().getKey() + "= ?";
			if(it.hasNext()){
				set += ", ";
			}
		}

		db.prepareStatement(sql + set + where);

		db.setObject(map.size() + 1, id.getValue());

		int i = 1;
		for (Object value : map.values()) {
			db.setObject(i++, value);
		}
		db.executeUpdate();
		db.commit();
	}
	
		public static void Deleta(MeuPreparedStatement db, String tabela, Map<Object, Object> map)
					throws SQLException {
		String sql = "DELETE " + tabela + " WHERE";

		for (Entry<Object, Object> e : map.entrySet()) {
			sql += " " + e.getKey() + "= ?";
		}

		db.prepareStatement(sql);

		int i = 1;
		for (Object value : map.values()) {
			db.setObject(i++, value);
		}
		db.executeUpdate();
		db.commit();
	}
}
