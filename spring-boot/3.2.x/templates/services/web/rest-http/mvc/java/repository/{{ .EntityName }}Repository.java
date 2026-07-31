package {{ .PackageName }}.repository;

import java.util.List;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

import org.springframework.stereotype.Repository;

import {{ .PackageName }}.model.{{ .EntityName }};

/**
 * In-memory store, so the generated project runs with no database to set up.
 *
 * Replace this with a real implementation - or generate a variant that ships one - by adding a
 * database level under the mvc/ template. The layer boundary is what matters here: the service
 * depends on this type, not on how anything is stored.
 */
@Repository
public class {{ .EntityName }}Repository {

    private final ConcurrentHashMap<Long, {{ .EntityName }}> store = new ConcurrentHashMap<>();
    private final AtomicLong sequence = new AtomicLong();

    public List<{{ .EntityName }}> findAll() {
        return List.copyOf(store.values());
    }

    public Optional<{{ .EntityName }}> findById(Long id) {
        return Optional.ofNullable(store.get(id));
    }

    public {{ .EntityName }} save(String name) {
        long id = sequence.incrementAndGet();
        {{ .EntityName }} saved = new {{ .EntityName }}(id, name);
        store.put(id, saved);
        return saved;
    }

    public boolean deleteById(Long id) {
        return store.remove(id) != null;
    }
}
