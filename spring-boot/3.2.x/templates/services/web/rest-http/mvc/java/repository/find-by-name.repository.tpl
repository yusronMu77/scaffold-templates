
    // Spliced by insert_after, not written as a file of its own - see mvc/jig.yaml
    // (WithSearchByName). Filters the in-memory store by the entity's default `name` field, so
    // this only compiles as-is against the default single-field entity (see mvc/jig.yaml's own
    // note on the same assumption for `create()`'s worked example).
    public List<{{ .EntityName }}> findByName(String name) {
        return store.values().stream()
                .filter(item -> item.name().equals(name))
                .toList();
    }
