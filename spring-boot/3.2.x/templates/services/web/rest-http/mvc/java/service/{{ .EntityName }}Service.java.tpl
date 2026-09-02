{{ include "java.header" . }}
package {{ .PackageName }}.service;

import java.util.List;

import org.springframework.stereotype.Service;

import {{ .PackageName }}.model.{{ .EntityName }};
import {{ .PackageName }}.repository.{{ .EntityName }}Repository;

/**
 * Business logic. The controller stays thin and the repository stays dumb; anything that is a rule
 * about the domain belongs here.
 */
@Service
public class {{ .EntityName }}Service {

    private final {{ .EntityName }}Repository repository;

    public {{ .EntityName }}Service({{ .EntityName }}Repository repository) {
        this.repository = repository;
    }

    public List<{{ .EntityName }}> findAll() {
        return repository.findAll();
    }

    public {{ .EntityName }} findById(Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new {{ .EntityName }}NotFoundException(id));
    }

    public {{ .EntityName }} create({{ include "entity.params" . }}) {
        return repository.save({{ include "entity.args" . }});
    }

    public void delete(Long id) {
        if (!repository.deleteById(id)) {
            throw new {{ .EntityName }}NotFoundException(id);
        }
    }

    // @scaffold:service-methods
}
