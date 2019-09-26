package dao;

import java.util.List;

import model.Page;
import model.Template;

public interface ITemplateDao {
	List<Template> queryTemplate(Template template);
	void addTemplate(Template template);
	void updateTemplate(Template template);
	void deleteTemplate(Integer id);
	List<Template> queryTemplateByPage(Page<Template> page);
}
