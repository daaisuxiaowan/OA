package dao;

import java.util.List;

import model.Approveinfo;

public interface IApproveinfoDao {
	List<Approveinfo> queryApproveinfo(Approveinfo approveinfo);
	void addApproveinfo(Approveinfo approveinfo);
}
