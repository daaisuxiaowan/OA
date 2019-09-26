package dao;

import java.util.List;

import model.Act;
import model.Page;

public interface IActDao {
	List<Act> queryAct(Act act);
	void addAct(Act act);
	void updateAct(Act act);
	void deleteAct(Act act);
	List<Act> queryActByPage(Page<Act> page);
}	
