
    // Spliced by insert_after - see mvc/jig.yaml (WithSearchByName).
    public List<{{ .EntityName }}> findByName(String name) {
        return repository.findByName(name);
    }
