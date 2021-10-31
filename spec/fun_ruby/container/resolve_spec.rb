# frozen_string_literal: true

require_lib "fun_ruby/container"
require_lib "fun_ruby/container/resolve"

describe FunRuby::Container::Resolve do
  it "resolves top-level function" do
    function = ->(x, y) { x + y }
    container = FunRuby::Container.new
    container.define("key") { function }
    resolve = described_class.build(container: container)

    expect(resolve.call("key")).to eq(function)
  end

  it "resolves a single-namespaced function" do
    function = ->(x, y) { x + y }
    container = FunRuby::Container.new
    container.define("namespace.key") { function }
    resolve = described_class.build(container: container, aliases: ["namespace"])

    expect(resolve.call("key")).to eq(function)
  end

  it "resolves a double-namespaced function" do
    function = ->(x, y) { x + y }
    container = FunRuby::Container.new
    container.define("app.namespace.key") { function }
    resolve = described_class.build(container: container, aliases: ["app.namespace"])

    expect(resolve.call("app.namespace.key")).to eq(function)
  end

  it "resolves a function under a fully-aliased namespace" do
    function = ->(x, y) { x + y }
    container = FunRuby::Container.new
    container.define("app.namespace.key") { function }
    resolve = described_class.build(container: container, aliases: ["app.namespace" => "alias"])

    expect(resolve.call("alias.key")).to eq(function)
  end

  it "resolves a function under a partially-aliased namespace" do
    function = ->(x, y) { x + y }
    container = FunRuby::Container.new
    container.define("root.app.namespace.key") { function }
    resolve = described_class.build(container: container, aliases: ["app.namespace" => "alias"])

    expect(resolve.call("root.alias.key")).to eq(function)
  end
end