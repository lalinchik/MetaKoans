class Module
  def attribute sym, &block
    name = sym
    name, default = sym.first if sym.is_a? Hash
    ivar = "@" + name

    define_method name do
      unless instance_variable_get ivar
        instance_variable_set ivar, (block ? instance_eval(&block) : default)
      end
      instance_variable_get ivar
    end

    define_method(name+'=') { |v| instance_variable_set ivar, v}
    define_method(name+'?') { instance_variable_get ivar}
  end
end