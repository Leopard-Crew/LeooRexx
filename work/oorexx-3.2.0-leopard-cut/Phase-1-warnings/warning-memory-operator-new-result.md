# Warning Cleanup: MemorySegmentPool operator new

## Change

The special allocator for `MemorySegmentPool` was declared non-throwing in:

```text
src/oorexx-3.2.0-leopard/kernel/runtime/RexxMemory.hpp
src/oorexx-3.2.0-leopard/kernel/platform/unix/MemorySupport.cpp
````

Before:

```c
void *MemorySegmentPool::operator new(size_t size, size_t minSize)
```

After:

```c
void *MemorySegmentPool::operator new(size_t size, size_t minSize) throw()
```

## Rationale

The allocator can report a resource exception and return `NULL`.

GCC warns when an `operator new` may return `NULL` unless the operator is explicitly declared non-throwing or `-fcheck-new` is used.

The local `throw()` declaration is narrower and safer than changing global compiler behavior.

## Validation

The source cut was rebuilt using:

```text
tools/leopard_build_test.sh warning-memory-operator-new-test
```

Check result:

```text
No MemorySupport operator new warning.
```

## Conclusion

The MemorySupport `operator new` warning is fixed without changing global build flags.  
