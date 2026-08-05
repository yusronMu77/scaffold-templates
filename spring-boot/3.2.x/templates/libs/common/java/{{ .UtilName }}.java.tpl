package {{ .PackageName }};

/**
 * Worked example of a shared utility. Plain Java on purpose - a common library that drags Spring
 * onto every consumer''s classpath stops being common very quickly.
 */
public final class {{ .UtilName }} {

    private {{ .UtilName }}() {
    }

    public static boolean isBlank(String value) {
        return value == null || value.isBlank();
    }

    public static String orDefault(String value, String fallback) {
        return isBlank(value) ? fallback : value;
    }
}
